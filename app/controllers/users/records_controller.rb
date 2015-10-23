class Users::RecordsController < UsersController
  # override so SOA's cannot be created by themselves
  def self._add_sti_create_links
    new_action_link = active_scaffold_config.action_links.collection['new']
    unless new_action_link.nil? || active_scaffold_config.sti_children.empty?
      active_scaffold_config.action_links.collection.delete('new')
      sti_children = active_scaffold_config.sti_children - [:SOA]
      sti_children.each do |child|
        new_sti_link = Marshal.load(Marshal.dump(new_action_link)) # deep clone
        new_sti_link.label = child.to_s.camelize.constantize.model_name.human
        new_sti_link.parameters = {:parent_sti => controller_path}
        new_sti_link.controller = Proc.new { active_scaffold_controller_for(child.to_s.camelize.constantize).controller_path }
        active_scaffold_config.action_links.collection.create.add(new_sti_link)
      end
      active_scaffold_config.action_links.collection.create.name = "Add Record"
    end
  end

  respond_to :html, :xml, :json

  active_scaffold :record do |conf|
    conf.sti_children = [:SOA, :NS, :MX, :A, :CNAME, :TXT, :AAAA, :SRV]
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date, :authentication_token]
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    # conf.create.link.label = "Add Record"
    conf.actions.exclude :show
    conf.action_links.add 'new_token', label: 'New Token', method: :put,
      security_method: :a_record?, type: :member, position: false, confirm: 'Are you sure?'
  end
  include RecordsControllerCommon
  with_options(:only => :modify) do |c|
    c.skip_before_filter :ensure_nested_under_domain
    c.skip_before_filter :authenticate_user!
    c.skip_before_filter :set_user_current
    c.skip_authorize_resource
  end
  protect_from_forgery :except => 'modify'

  MODIFY_ERROR = 'ERROR: only A records can be modified with this API'
  MODIFY_OK = 'OK'

  # TODO: externalize
  def modify
    @record = Record.where(:authentication_token => params[:authentication_token]).first!
    return render(:text => MODIFY_ERROR) if @record.type != 'A'
    @record.content = params[:ip] || client_remote_ip
    @record.save!
    render(:text => MODIFY_OK)
  end

  protected

  def new_model
    record = super
    before_create_save(record)
    record
  end

  # just to limit the action to A type records
  def a_record?(record)
    record.class == A
  end
end
