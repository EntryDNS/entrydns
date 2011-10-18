class HostsController < ApplicationController
  active_scaffold :a do |conf|
    conf.columns = [:name, :host_domain, :content, :ttl, :change_date, :authentication_token]
    conf.list.columns = [:name, :content, :ttl, :change_date, :authentication_token]
    conf.create.columns = [:name, :host_domain, :content, :ttl,]
    conf.update.columns = [:name, :host_domain, :content, :ttl]
    conf.list.label = 'Hosts'
    conf.create.link.label = "Add Host"
    conf.columns[:host_domain].form_ui = :select
    conf.columns[:host_domain].options = {:options => Settings.host_domains}
    conf.columns[:name].label = 'Host'
    conf.columns[:content].label = 'IP'
    conf.columns[:content].description = 'Ex. "10.10.5.12"'
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    conf.actions.exclude :show
  end
  
  protected

  def new_model
    record = super
    record.content = client_remote_ip    
    before_create_save(record)
    record
  end
  
  def before_create_save(record)
    record.user = current_user
  end

end
