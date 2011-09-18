class DomainsController < ApplicationController
  active_scaffold :domain do |conf|
    conf.columns = [:name, :records]
    conf.actions.exclude :show
  end
  
  protected
  
  def before_create_save(record)
    record.type = 'NATIVE'
  end
  
end
