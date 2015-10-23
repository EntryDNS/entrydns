class Users::CnamesController < UsersController
  active_scaffold :cname do |conf|
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date, :authentication_token]
    conf.create.columns = [:name, :content, :ttl]
    conf.update.columns = [:name, :content, :ttl]
    conf.columns[:name].description = 'CNAME'
    conf.columns[:content].label = 'Destination'
    conf.columns[:content].description = 'FQDN Ex. "host.domain.com"'
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    conf.actions.exclude :show
  end
  include RecordsControllerCommon

  protected

  def beginning_of_chain
    (nested_via_records? ? nested_parent_record.cname_records : super).readonly(false)
  end

  # override, we make our own sti logic
  def new_model
    record = beginning_of_chain.new
    before_create_save(record)
    record
  end

end
