class RecordsController < ApplicationController
  active_scaffold :record do |conf|
    conf.sti_children = [:SOA, :NS]
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date]
    conf.actions.exclude :show
  end
  before_filter :ensure_nested_under_domain
  
  protected
  
  def beginning_of_chain
    super.readonly(false)
  end
  
  def ensure_nested_under_domain
    raise CanCan::AccessDenied, "not found" unless nested? and nested_parent_record.is_a?(Domain)
  end
end
