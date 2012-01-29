class DomainsController < ApplicationController
  
  active_scaffold :domain do |conf|
    conf.columns = [:name, :ip, :records, :soa_record, :ns_records]
    conf.list.columns = [:name, :records, :permissions]
    conf.create.columns = [:name, :ip, :soa_record, :ns_records]
    conf.update.columns = [:name, :soa_record]
    conf.columns[:name].description = 'Ex. "domain.com"'
    conf.columns[:ip].description = 'Ex. "10.10.5.12", optional IP to associate your domain with'
    conf.columns[:ns_records].show_blank_record = false
    conf.columns[:permissions].label = 'Sharing'
    conf.actions.exclude :show
    conf.list.sorting = {:name => :asc}
    conf.create.link.label = 'Add Domain'
    
    # conf.columns[:records].label = 'All Records'
  end
  
  protected
  
  def beginning_of_chain
    super.readonly(false)
  end
  
  def do_new
    super
    @record.setup(current_user.email)
  end
  
  def new_model
    record = super
    before_create_save(record)
    record
  end
    
  def before_create_save(record)
    record.type = 'NATIVE'
    record.user = record.parent_domain.present? ? record.parent_domain.user : current_user
  end

  def after_create_save(record)
    @record.reload
  end
  
  def before_update_save(record) # just to make sure of params tampering
    record.type = 'NATIVE'
    @name_changed = @record.name_changed?
  end

  def after_update_save(record)
    if @name_changed
      flash.now[:warning] = "Changing the name of a domain migrates all it's records to the new name!"
    end
    @record.reload
  end
  
end
