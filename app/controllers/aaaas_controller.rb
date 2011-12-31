class AaaasController < ApplicationController
  active_scaffold :aaaa do |conf|
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date, :authentication_token]
    conf.create.columns = [:name, :content, :ttl,]
    conf.update.columns = [:name, :content, :ttl]
    conf.columns[:content].label = 'IP v6'
    conf.columns[:content].description = 'Ex. "2001:0db8:85a3:0000:0000:8a2e:0370:7334"'
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    conf.actions.exclude :show
  end
  before_filter :ensure_nested_under_domain
  
  protected
  
  # override to use :mx_records instead of :records assoc
  def beginning_of_chain
    nested_via_records? ? nested.parent_scope.aaaa_records : super
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