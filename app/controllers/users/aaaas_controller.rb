class Users::AaaasController < UsersController
  active_scaffold :aaaa do |conf|
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date, :authentication_token]
    conf.create.columns = [:name, :content, :ttl,]
    conf.update.columns = [:name, :content, :ttl]
    conf.columns[:content].label = 'IP v6'
    conf.columns[:content].description = 'Ex. "2001:0db8:85a3:0000:0000:8a2e:0370:7334"'
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    conf.actions.exclude :show
  end
  include RecordsControllerCommon

  protected

  def beginning_of_chain
    (nested_via_records? ? nested_parent_record.aaaa_records : super).readonly(false)
  end

  # override, we make our own sti logic
  def new_model
    record = beginning_of_chain.new
    record.name = nested_parent_record.name
    before_create_save(record)
    record
  end
end
