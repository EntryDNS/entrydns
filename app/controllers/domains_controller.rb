class DomainsController < ApplicationController
  
  active_scaffold :domain do |conf|
    conf.columns = [:name, :soa_record, :ns_records, :records]
    conf.list.columns = [:name, :soa_record, :ns_records, :records]
    conf.create.columns = [:name, :soa_record, :ns_records]
    conf.update.columns = [:name, :soa_record, :ns_records]
    conf.actions.exclude :show
    conf.list.sorting = { :name => :asc }
    
    conf.columns[:records].label = 'All Records'
  end
  
  protected
    
  def before_create_save(record)
    record.type = 'NATIVE'
  end
    
end
