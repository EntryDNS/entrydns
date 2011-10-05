class SoasController < ApplicationController
  active_scaffold :soa do |conf|
    conf.list.columns = [:name, :type, :content, :ttl, :prio, :change_date]
    conf.create.columns = [:contact, :ttl]
    conf.update.columns = [:contact, :ttl]
    conf.columns[:change_date].list_ui = :timestamp
    conf.actions.exclude :delete, :show
  end
  before_filter :ensure_nested_under_domain
  
  protected
  
  # override to use :mx_records instead of :records assoc
  def beginning_of_chain
    super.readonly(false)
  end
  
  # override, we make our own sti logic
  def new_model
    model = beginning_of_chain
    model.new
  end

  # override to close create form after success  
  def render_parent?
    nested_singular_association? # || params[:parent_sti]
  end
  
end
