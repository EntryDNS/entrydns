class DomainsController < ApplicationController
  active_scaffold :domain do |conf|
    conf.columns = [:name, :last_check, :notified_serial, :account]
  end
  
  protected
  
  def before_create_save(record)
    record.type = 'NATIVE'
  end
  
end
