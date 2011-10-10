class AsController < ApplicationController
  respond_to :html, :xml, :json
  
  active_scaffold :a do |conf|
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date, :authentication_token]
    conf.create.columns = [:name, :content, :ttl,]
    conf.update.columns = [:name, :content, :ttl]
    conf.columns[:content].label = 'IP'
    conf.columns[:content].description = 'Ex. "10.10.5.12"'
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    conf.actions.exclude :show
  end
  before_filter :ensure_nested_under_domain, :except => 'modify'
  skip_before_filter :authenticate_user!, :only => 'modify'
  protect_from_forgery :except => 'modify'
  skip_authorize_resource :only => :modify
  
  # TODO: externalize
  def modify
    @a = A.where(:authentication_token => params[:authentication_token]).first!
    @a.content = params[:ip] || client_remote_ip
    @a.save!
    respond_with @a
  end
  
  protected
  
  # override to use :mx_records instead of :records assoc
  def beginning_of_chain
    if nested? && nested.association && nested.association.collection? && nested.association.name == :records
      nested.parent_scope.a_records
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