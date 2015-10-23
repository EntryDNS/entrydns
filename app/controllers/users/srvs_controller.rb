class Users::SrvsController < UsersController
  active_scaffold :srv do |conf|
    conf.columns = [:name, :type, :content, :weight, :port, :host, :ttl, :prio, :change_date, :authentication_token]
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date, :authentication_token]
    conf.create.columns = [:name, :weight, :host, :port, :ttl, :prio]
    conf.update.columns = [:name, :weight, :host, :port, :ttl, :prio]
    conf.columns[:content].description = 'Ex. "_http._tcp.example.com"'
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    conf.actions.exclude :show
  end
  include RecordsControllerCommon

  protected

  def do_new
    super
    @record.prio ||= 0
  end

  def beginning_of_chain
    (nested_via_records? ? nested_parent_record.srv_records : super).readonly(false)
  end

  # override, we make our own sti logic
  def new_model
    record = beginning_of_chain.new
    record.name = nested_parent_record.name
    before_create_save(record)
    record
  end

end
