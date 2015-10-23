class Users::AsController < UsersController
  active_scaffold :a do |conf|
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date, :authentication_token]
    conf.create.columns = [:name, :content, :ttl,]
    conf.update.columns = [:name, :content, :ttl]
    conf.columns[:content].label = 'IP v4'
    conf.columns[:content].description = 'Ex. "10.10.5.12"'
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    conf.actions.exclude :show
    conf.action_links.add 'new_token', label: 'New Token', method: :put,
      type: :member, position: false, confirm: 'Are you sure?'
  end
  include RecordsControllerCommon

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

  def beginning_of_chain
    (nested_via_records? ? nested_parent_record.a_records : super).readonly(false)
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
