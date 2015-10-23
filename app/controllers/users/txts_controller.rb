class Users::TxtsController < UsersController
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
  include RecordsControllerCommon

  protected

  def beginning_of_chain
    (nested_via_records? ? nested_parent_record.txt_records : super).readonly(false)
  end

  # override, we make our own sti logic
  def new_model
    record = beginning_of_chain.new
    record.name = nested_parent_record.name
    before_create_save(record)
    record
  end
end
