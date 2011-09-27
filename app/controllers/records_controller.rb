class RecordsController < ApplicationController
  active_scaffold :record do |conf|
    conf.sti_children = [:SOA, :NS]
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date]
  end
  
  protected
  
  def beginning_of_chain
    super.readonly(false)
  end
end
