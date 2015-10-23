class Users::NsController < UsersController
  active_scaffold :ns do |conf|
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date, :authentication_token]
    conf.create.columns = [:name, :content, :ttl]
    conf.update.columns = [:name, :content, :ttl]
    conf.subform.columns = [:content, :ttl]
    conf.columns[:content].label = 'NS'
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    conf.actions.exclude :show
  end
  include RecordsControllerCommon

  protected

  def beginning_of_chain
    (nested_via_records? ? nested_parent_record.ns_records : super).readonly(false)
  end

  # override, we make our own sti logic
  def new_model
    record = beginning_of_chain.new
    record.name = nested_parent_record.name
    record.content = Settings.ns.sample
    before_create_save(record)
    record
  end

  def after_update_save(record)
    domain = @record.domain
    soa_record = domain.soa_record
    unless domain.ns_records.any? {|ns_record| soa_record.primary_ns == ns_record.content}
      flash.now[:warning] = "SOA record's primary NS is no longer among this domain's NS records"
    end
  end

  def do_destroy
    if nested_parent_record.ns_records.count > 1
      @record ||= destroy_find_record
      begin
        self.successful = @record.destroy
      rescue Exception => ex
        flash[:warning] = as_(:cant_destroy_record, :record => @record.to_label)
        self.successful = false
        logger.debug ex.message
        logger.debug ex.backtrace.join("\n")
      end
    else
      self.successful = false
      flash[:error] = "Cannot delete it, the domain must have at least one nameserver!"
    end
  end
end
