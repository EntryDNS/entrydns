class RecordsController < ApplicationController
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
  end
  before_filter :ensure_nested_under_domain, :except => 'modify'
  skip_before_filter :authenticate_user!, :only => 'modify'
  protect_from_forgery :except => 'modify'
  skip_authorize_resource :only => :modify
  
  MODIFY_ERROR = 'ERROR: only A records can be modified with this API'
  MODIFY_OK = 'OK'
  
  # TODO: externalize
  def modify
    @record = Record.where(:authentication_token => params[:authentication_token]).first!
    if @record.type != 'A'
      return render :text => MODIFY_ERROR
    end
    @record.content = params[:ip] || client_remote_ip
    @record.save!
    respond_with(@record) do |format|
      format.html {
        render :text => MODIFY_OK
      }
    end
  end
end
