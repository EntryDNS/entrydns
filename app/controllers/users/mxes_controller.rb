class Users::MxesController < UsersController
  active_scaffold :mx do |conf|
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date, :authentication_token]
    conf.create.columns = [:content, :ttl, :prio]
    conf.update.columns = [:content, :ttl, :prio]
    conf.columns[:content].label = 'MX'
    conf.columns[:content].description = 'Ex. "mail.domain.com"'
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    conf.actions.exclude :show
  end
  include RecordsControllerCommon

  protected

  def do_new
    super
    @record.prio ||= begin
      maximum = nested_parent_record.mx_records.maximum(:prio)
      maximum.nil? ? Settings.default_prio : maximum + 10
    end
  end

  def beginning_of_chain
    (nested_via_records? ? nested_parent_record.mx_records : super).readonly(false)
  end

  # override, we make our own sti logic
  def new_model
    record = beginning_of_chain.new
    record.name = nested_parent_record.name
    before_create_save(record)
    record
  end
end
