class Users::HostsController < UsersController
  active_scaffold :a do |conf|
    conf.columns = [:name, :host_domain, :content, :ttl, :change_date, :authentication_token]
    conf.list.columns = [:name, :content, :ttl, :change_date, :authentication_token]
    conf.create.columns = [:name, :host_domain, :content, :ttl]
    conf.update.columns = [:name, :host_domain, :content, :ttl]
    conf.list.label = 'Hosts'
    conf.list.sorting = {name: :asc}
    conf.create.link.label = "Add Host"
    conf.columns[:host_domain].form_ui = :select
    conf.columns[:host_domain].options = {options: Settings.host_domains}
    conf.columns[:name].label = 'Host'
    conf.columns[:name].description = 'Ex. "your-name"'
    conf.columns[:content].label = 'IP'
    conf.columns[:content].description = 'Ex. "10.10.5.12"'
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {i18n_number: {delimiter: ''}}
    conf.actions.exclude :show
    conf.action_links.add 'new_token', label: 'New Token', method: :put,
      type: :member, position: false, confirm: 'Are you sure?'
  end

  def new_token
    process_action_link_action do |record|
      record.instance_variable_set(:@readonly, false)
      record.generate_token
      update_save(no_record_param_update: true)
      if successful?
        flash[:info] = "Token was updated successfully to #{record.authentication_token}"
      end
    end
  end

  protected

  def new_model
    record = super
    record.content = client_remote_ip
    before_create_save(record)
    record
  end

  def beginning_of_chain
    super.includes(:domain).
      where(:domains => {:name => Settings.host_domains}).
      readonly(false)
  end

  def before_create_save(record)
    record.user = current_user
  end

end
