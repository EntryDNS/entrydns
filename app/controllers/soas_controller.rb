class SoasController < ApplicationController
  active_scaffold :soa do |conf|
    conf.columns = [:name, :primary_ns, :contact, :ttl]
    conf.update.columns = [:contact, :ttl]
    conf.actions.exclude :delete
    conf.actions.exclude :show
  end
  
  protected
  
  def beginning_of_chain
    super.readonly(false)
  end
end
