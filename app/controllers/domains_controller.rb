class DomainsController < ApplicationController
  
  active_scaffold :domain do |conf|
    conf.columns = [:name, :soa_record, :ns_records, :records]
    conf.list.columns = [:name, :soa_record, :ns_records, :records]
    conf.create.columns = [:name, :soa_record, :ns_records]
    conf.update.columns = [:name, :soa_record, :ns_records]
    conf.columns[:name].description = 'yourdomain.com'
    conf.columns[:ns_records].show_blank_record = false
    conf.actions.exclude :show
    conf.list.sorting = { :name => :asc }
    conf.create.link.label = "Add Domain"
    
    conf.columns[:records].label = 'All Records'
  end
  
  protected
  
  def do_new
    super
    session[:sample_ns] = nil
    @record.setup(current_user.email, sample_ns)
  end
    
  def before_create_save(record)
    record.type = 'NATIVE'
  end

  def after_create_save(record)
    session[:sample_ns] = nil
    @record.reload
  end
  
  def sample_ns
    session[:sample_ns] ||= Settings.ns.sample(2)
  end
      
end
