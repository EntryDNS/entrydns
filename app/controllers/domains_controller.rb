class DomainsController < ApplicationController
  active_scaffold :domain do |conf|
    conf.columns = [:name, :records]
    conf.create.columns = [:name]
    conf.update.columns = [:name]
    conf.actions.exclude :show
    conf.list.sorting = { :name => :asc }
  end
  
  protected
  
  def before_create_save(record)
    record.type = 'NATIVE'
  end
  
end
