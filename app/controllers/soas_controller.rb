class SoasController < ApplicationController
  active_scaffold :soa do |conf|
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date, :authentication_token]
    conf.create.columns = [:contact, :ttl]
    conf.update.columns = [:contact, :ttl]
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    conf.actions.exclude :delete, :show
  end
  before_filter :ensure_nested_under_domain
  
  protected
  
  def beginning_of_chain
    (nested_via_records? ? nested.parent_scope.soa_records : super).readonly(false)
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
  
  def after_update_save(record)
    unless @record.domain.ns_records.any? {|ns_record| @record.primary_ns == ns_record.content}
      flash.now[:warning] = "SOA record's primary NS is no longer among this domain's NS records"
    end
  end
  
end
