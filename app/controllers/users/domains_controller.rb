class Users::DomainsController < UsersController  
  active_scaffold :domain do |conf|
    conf.columns = [:name, :ip, :records, :soa_record, :ns_records, :apply_subdomains]
    conf.list.columns = [:name, :records, :permissions]
    conf.create.columns = [:name, :ip, :soa_record, :ns_records]
    conf.update.columns = [:name, :apply_subdomains]
    conf.columns[:name].description = 'Ex. "domain.com"'
    conf.columns[:ip].description = 'Ex. "10.10.5.12", optional IP to associate your domain with'
    conf.columns[:ns_records].show_blank_record = false
    conf.columns[:permissions].label = 'Sharing'
    conf.columns[:apply_subdomains].label = 'Also rename subdomains'
    conf.columns[:apply_subdomains].description = 'If checked, will also rename all subdomains accordingly'
    conf.columns[:apply_subdomains].form_ui = :checkbox
    conf.columns[:apply_subdomains].options = { :class => 'checkbox', checked: true }
    conf.actions.exclude :show
    conf.create.refresh_list = true # because tree structure might change
    conf.update.refresh_list = true # because tree structure might change
    conf.create.link.label = 'Add Domain'
    [:name, :records, :permissions].each do |c|
      conf.columns[c].sort = false
    end
    conf.list.sorting = [{rgt: :desc}, {lftp: :asc}] # preorder
    conf.columns[:name].css_class = 'sorted'

    # conf.columns[:records].label = 'All Records'
  end

  protected

  def beginning_of_chain
    super.readonly(false)
  end

  def do_new
    super
    @record.setup(current_user.email)
  end

  def do_create
    super
    if !successful? && @record.domain_ownership_failed
      @record.user = current_user
    end
  end

  def do_destroy
    @record ||= destroy_find_record
    begin
      self.successful = @record.destroy
      marked_records.delete @record.id.to_s if successful?
    rescue ActiveRecord::DeleteRestrictionError => e
      flash[:warning] = as_(:cant_destroy_record, :record => @record.to_label)
      @record.errors.add :base, "Delete subdomains first"
      self.successful = false
    rescue
      flash[:warning] = as_(:cant_destroy_record, :record => @record.to_label)
      self.successful = false
    end
  end

  def new_model
    record = super
    before_create_save(record)
    record
  end

  # override to add locking
  def update_save(options = {})
    attributes = options[:attributes] || params[:record]
    begin
      active_scaffold_config.model.transaction do
        @record = update_record_from_params(@record, active_scaffold_config.update.columns, attributes) unless options[:no_record_param_update]
        before_update_save(@record)
        self.successful = [@record.valid?, @record.associated_valid?].all? {|v| v == true} # this syntax avoids a short-circuit
        if successful?
          ActiveRecord::Base.connection.execute("LOCK TABLES domains WRITE, records WRITE, permissions READ") if @name_changed
          @record.save! and @record.save_associated!
          after_update_save(@record)
        else
          # some associations such as habtm are saved before saved is called on parent object
          # we have to revert these changes if validation fails
          raise ActiveRecord::Rollback, "don't save habtm associations unless record is valid"
        end
      end
    rescue ActiveRecord::StaleObjectError
      @record.errors.add(:base, as_(:version_inconsistency))
      self.successful = false
    rescue ActiveRecord::RecordNotSaved
      @record.errors.add(:base, as_(:record_not_saved)) if @record.errors.empty?
      self.successful = false
    rescue ActiveRecord::ActiveRecordError => ex
      flash[:error] = ex.message
      self.successful = false
    ensure
      ActiveRecord::Base.connection.execute("UNLOCK TABLES") if @name_changed
    end
  end

  def before_create_save(record)
    record.type = 'NATIVE'
    record.user = record.parent_domain.present? ? record.parent_domain.user : current_user
  end

  def after_create_save(record)
    @record.reload
    flash[:info] = "Domain #{@record.name} was created successfully"
  end

  def before_update_save(record) # just to make sure of params tampering
    record.type = 'NATIVE'
    @name_changed = @record.name_changed?
  end

  def after_update_save(record)
    flash[:info] = "Domain #{@record.name} was updated successfully"
    if @name_changed
      flash.now[:warning] = "Changing the name of a domain migrates all it's records to the new name!"
    end
    @record.reload
  end

end
