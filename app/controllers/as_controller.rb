class AsController < ApplicationController
  active_scaffold :a do |conf|
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date, :authentication_token]
    conf.create.columns = [:name, :content, :ttl,]
    conf.update.columns = [:name, :content, :ttl]
    conf.columns[:content].label = 'IP v4'
    conf.columns[:content].description = 'Ex. "10.10.5.12"'
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    conf.actions.exclude :show
  end
  include RecordsControllerCommon
  
  protected
  
  # override to use :mx_records instead of :records assoc
  def beginning_of_chain
    (nested_via_records? ? nested.parent_scope.a_records : super).readonly(false)
  end
  
  # override, we make our own sti logic
  def new_model
    record = beginning_of_chain.new
    record.name = nested_parent_record.name
    record.content = client_remote_ip if client_remote_ip.present?
    before_create_save(record)
    record
  end
end