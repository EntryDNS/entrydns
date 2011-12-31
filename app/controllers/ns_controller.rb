class NsController < ApplicationController
  active_scaffold :ns do |conf|
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date, :authentication_token]
    conf.create.columns = [:name, :content, :ttl]
    conf.update.columns = [:name, :content, :ttl]
    conf.subform.columns = [:content, :ttl]
    conf.columns[:content].label = 'NS'
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    conf.actions.exclude :show
  end
  before_filter :ensure_nested_under_domain
  
  protected
  
  # override to use :mx_records instead of :records assoc
  def beginning_of_chain
    nested_via_records? ? nested.parent_scope.ns_records : super
  end
  
  # override, we make our own sti logic
  def new_model
    model = beginning_of_chain.new
    model.name = nested_parent_record.name
    model.content = Settings.ns.sample
    model
  end

  # override to close create form after success  
  def render_parent?
    nested_singular_association? # || params[:parent_sti]
  end
  
  def after_update_save(record)
    domain = @record.domain
    soa_record = domain.soa_record
    unless domain.ns_records.any? {|ns_record| soa_record.primary_ns == ns_record.content}
      flash.now[:warning] = "SOA record's primary NS is no longer among this domain's NS records"
    end
  end
  
  def do_destroy
    super
    if successful? && nested_parent_record.ns_records.count == 0
      flash[:warning] = "All NS records deleted, no other nameservers are associated with this domain!"
    end
  end
  
end
