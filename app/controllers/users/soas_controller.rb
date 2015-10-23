class Users::SoasController < UsersController
  active_scaffold :soa do |conf|
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date, :authentication_token]
    conf.create.columns = [:contact, :ttl]
    conf.update.columns = [:contact, :ttl]
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    conf.actions.exclude :delete, :show
  end
  include RecordsControllerCommon

  protected

  def beginning_of_chain
    (nested_via_records? ? nested_parent_record.soa_records : super).readonly(false)
  end

  # override, we make our own sti logic
  def new_model
    record = beginning_of_chain.new
    before_create_save(record)
    record
  end

  def after_update_save(record)
    flash.now[:warning] = "SOA record's primary NS is no longer among this domain's NS records" unless record.ns?
  end
end
