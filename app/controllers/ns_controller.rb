class NsController < ApplicationController
  active_scaffold :ns do |conf|
    conf.columns = [:name, :content, :ttl]
    conf.columns[:content].label = 'Hostname'
  end
  
  protected
  
  def beginning_of_chain
    super.readonly(false)
  end
end
