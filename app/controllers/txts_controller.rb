class TxtsController < ApplicationController
  active_scaffold :txt do |conf|
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date, :authentication_token]
    conf.create.columns = [:name, :content, :ttl]
    conf.update.columns = [:name, :content, :ttl]
    # conf.columns[:content].label = 'Content'
    # conf.columns[:content].description = 'Ex. can be many things'
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    conf.actions.exclude :show
  end
  before_filter :ensure_nested_under_domain
  
  protected
  
  # override to use :mx_records instead of :records assoc
  def beginning_of_chain
    nested_via_records? ? nested.parent_scope.txt_records : super
  end
  
  # override, we make our own sti logic
  def new_model
    record = beginning_of_chain.new
    record.name = nested_parent_record.name
    before_create_save(record)
    record
  end
  
  def before_create_save(record)
    record.user = current_user
  end

  # override to close create form after success  
  def render_parent?
    nested_singular_association? # || params[:parent_sti]
  end
end 