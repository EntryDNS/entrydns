class TxtsController < ApplicationController
  active_scaffold :txt do |conf|
    conf.list.columns = [:name, :type, :content, :ttl, :prio, :change_date]
    conf.create.columns = [:name, :content, :ttl]
    conf.update.columns = [:name, :content, :ttl]
    # conf.columns[:content].label = 'Content'
    # conf.columns[:content].description = 'Ex. can be many things'
    conf.columns[:change_date].list_ui = :timestamp
    conf.actions.exclude :show
  end
  before_filter :ensure_nested_under_domain
  
  protected
  
  # override to use :mx_records instead of :records assoc
  def beginning_of_chain
    if nested? && nested.association && nested.association.collection? && nested.association.name == :records
      nested.parent_scope.txt_records
    else
      super
    end
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