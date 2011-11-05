class SrvsController < ApplicationController
  active_scaffold :srv do |conf|
    conf.columns = [:name, :type, :content, :weight, :port, :host, :ttl, :prio, :change_date, :authentication_token]
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date, :authentication_token]
    conf.create.columns = [:name, :weight, :host, :port, :ttl, :prio]
    conf.update.columns = [:name, :weight, :host, :port, :ttl, :prio]
    conf.columns[:content].description = 'Ex. "_http._tcp.example.com"'
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    conf.actions.exclude :show
  end
  before_filter :ensure_nested_under_domain
  
  protected
  
  def do_new
    super
    @record.prio ||= 0
  end
  
  # override to use :mx_records instead of :records assoc
  def beginning_of_chain
    if nested? && nested.association && nested.association.collection? && nested.association.name == :records
      nested.parent_scope.srv_records
    else
      super
    end
  end
  
  # override, we make our own sti logic
  def new_model
    model = beginning_of_chain.new
    model.name = nested_parent_record.name
    model
  end

  # override to close create form after success  
  def render_parent?
    nested_singular_association? # || params[:parent_sti]
  end
  
end 
