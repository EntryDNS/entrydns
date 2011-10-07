class MxesController < ApplicationController
  active_scaffold :mx do |conf|
    conf.list.columns = [:name, :type, :content, :ttl, :prio, :change_date]
    conf.create.columns = [:content, :ttl, :prio]
    conf.update.columns = [:content, :ttl, :prio]
    conf.columns[:content].label = 'MX'
    conf.columns[:content].description = 'Ex. "mail.domain.com"'
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    conf.actions.exclude :show
  end
  before_filter :ensure_nested_under_domain
  
  protected
  
  def do_new
    super
    @record.prio ||= begin
      maximum = nested_parent_record.mx_records.maximum(:prio)
      maximum.nil? ? Settings.default_prio : maximum + 10
    end
  end
  
  # override to use :mx_records instead of :records assoc
  def beginning_of_chain
    if nested? && nested.association && nested.association.collection? && nested.association.name == :records
      nested.parent_scope.mx_records
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
