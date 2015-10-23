require 'rails_admin/config/actions/ban'
require 'rails_admin/config/actions/unban'

RailsAdmin.config do |config|

  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  # require 'i18n'
  # I18n.default_locale = :de

  RailsAdmin.config do |config|
    config.authenticate_with do
      warden.authenticate! scope: :admin
    end
    config.current_user_method &:current_admin
  end

  # If you want to track changes on your models:
  # config.audit_with :history, Admin

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, Admin


  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Entrydns', 'Admin']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  config.authorize_with :cancan, AdminAbility

  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = [A, AAAA, Admin, CNAME, Domain, MX, NS, Permission, Record, SOA, SRV, TXT, User]

  # Add models here if you want to go 'whitelist mode':
  config.included_models = [A, AAAA, Admin, CNAME, Domain, MX, NS, Permission,
    Record, SOA, SRV, TXT, User, Authentication, BlacklistedDomain, PaperTrail::Version]

  config.model Authentication do |conf|
    parent User
  end

  config.model Permission do |conf|
    parent User
  end

  config.model Record do |conf|
    parent Domain
  end

  config.actions do
    # root actions
    dashboard                     # mandatory
    # collection actions
    index                         # mandatory
    new
    export
    history_index
    bulk_delete
    # member actions
    show
    edit
    delete
    history_show
    show_in_app
    ban
    unban
  end

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))

  config.model Setting do
    configure :value, :text
  end

  # config.model A do
  #   # Found associations:
  #     configure :domain, :belongs_to_association
  #     configure :user, :belongs_to_association
  #     configure :creator, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer
  #     configure :domain_id, :integer         # Hidden
  #     configure :name, :string
  #     configure :type, :string
  #     configure :content, :string
  #     configure :ttl, :integer
  #     configure :prio, :integer
  #     configure :change_date, :integer
  #     configure :authentication_token, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :user_id, :integer         # Hidden
  #     configure :creator_id, :integer         # Hidden
  #     configure :updator_id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model AAAA do
  #   # Found associations:
  #     configure :domain, :belongs_to_association
  #     configure :user, :belongs_to_association
  #     configure :creator, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer
  #     configure :domain_id, :integer         # Hidden
  #     configure :name, :string
  #     configure :type, :string
  #     configure :content, :string
  #     configure :ttl, :integer
  #     configure :prio, :integer
  #     configure :change_date, :integer
  #     configure :authentication_token, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :user_id, :integer         # Hidden
  #     configure :creator_id, :integer         # Hidden
  #     configure :updator_id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Admin do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer
  #     configure :email, :string
  #     configure :password, :password         # Hidden
  #     configure :password_confirmation, :password         # Hidden
  #     configure :reset_password_token, :string         # Hidden
  #     configure :reset_password_sent_at, :datetime
  #     configure :remember_created_at, :datetime
  #     configure :sign_in_count, :integer
  #     configure :current_sign_in_at, :datetime
  #     configure :last_sign_in_at, :datetime
  #     configure :current_sign_in_ip, :string
  #     configure :last_sign_in_ip, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model CNAME do
  #   # Found associations:
  #     configure :domain, :belongs_to_association
  #     configure :user, :belongs_to_association
  #     configure :creator, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer
  #     configure :domain_id, :integer         # Hidden
  #     configure :name, :string
  #     configure :type, :string
  #     configure :content, :string
  #     configure :ttl, :integer
  #     configure :prio, :integer
  #     configure :change_date, :integer
  #     configure :authentication_token, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :user_id, :integer         # Hidden
  #     configure :creator_id, :integer         # Hidden
  #     configure :updator_id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Domain do
  #   # Found associations:
  #     configure :user, :belongs_to_association
  #     configure :creator, :belongs_to_association
  #     configure :parent, :belongs_to_association
  #     configure :records, :has_many_association
  #     configure :permissions, :has_many_association
  #     configure :permitted_users, :has_many_association
  #     configure :soa_record, :has_one_association
  #     configure :soa_records, :has_many_association
  #     configure :ns_records, :has_many_association
  #     configure :a_records, :has_many_association
  #     configure :mx_records, :has_many_association
  #     configure :txt_records, :has_many_association
  #     configure :cname_records, :has_many_association
  #     configure :aaaa_records, :has_many_association
  #     configure :srv_records, :has_many_association
  #     configure :children, :has_many_association   #   # Found columns:
  #     configure :id, :integer
  #     configure :user_id, :integer         # Hidden
  #     configure :name, :string
  #     configure :master, :string
  #     configure :last_check, :integer
  #     configure :type, :string
  #     configure :notified_serial, :integer
  #     configure :account, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :name_reversed, :string
  #     configure :creator_id, :integer         # Hidden
  #     configure :updator_id, :integer
  #     configure :parent_id, :integer         # Hidden
  #     configure :lftp, :integer
  #     configure :lftq, :integer
  #     configure :rgtp, :integer
  #     configure :rgtq, :integer
  #     configure :lft, :float
  #     configure :rgt, :float   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model MX do
  #   # Found associations:
  #     configure :domain, :belongs_to_association
  #     configure :user, :belongs_to_association
  #     configure :creator, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer
  #     configure :domain_id, :integer         # Hidden
  #     configure :name, :string
  #     configure :type, :string
  #     configure :content, :string
  #     configure :ttl, :integer
  #     configure :prio, :integer
  #     configure :change_date, :integer
  #     configure :authentication_token, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :user_id, :integer         # Hidden
  #     configure :creator_id, :integer         # Hidden
  #     configure :updator_id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model NS do
  #   # Found associations:
  #     configure :domain, :belongs_to_association
  #     configure :user, :belongs_to_association
  #     configure :creator, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer
  #     configure :domain_id, :integer         # Hidden
  #     configure :name, :string
  #     configure :type, :string
  #     configure :content, :string
  #     configure :ttl, :integer
  #     configure :prio, :integer
  #     configure :change_date, :integer
  #     configure :authentication_token, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :user_id, :integer         # Hidden
  #     configure :creator_id, :integer         # Hidden
  #     configure :updator_id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Permission do
  #   # Found associations:
  #     configure :domain, :belongs_to_association
  #     configure :user, :belongs_to_association
  #     configure :creator, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer
  #     configure :domain_id, :integer         # Hidden
  #     configure :user_id, :integer         # Hidden
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :creator_id, :integer         # Hidden
  #     configure :updator_id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Record do
  #   # Found associations:
  #     configure :domain, :belongs_to_association
  #     configure :user, :belongs_to_association
  #     configure :creator, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer
  #     configure :domain_id, :integer         # Hidden
  #     configure :name, :string
  #     configure :type, :string
  #     configure :content, :string
  #     configure :ttl, :integer
  #     configure :prio, :integer
  #     configure :change_date, :integer
  #     configure :authentication_token, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :user_id, :integer         # Hidden
  #     configure :creator_id, :integer         # Hidden
  #     configure :updator_id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model SOA do
  #   # Found associations:
  #     configure :domain, :belongs_to_association
  #     configure :user, :belongs_to_association
  #     configure :creator, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer
  #     configure :domain_id, :integer         # Hidden
  #     configure :name, :string
  #     configure :type, :string
  #     configure :content, :string
  #     configure :ttl, :integer
  #     configure :prio, :integer
  #     configure :change_date, :integer
  #     configure :authentication_token, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :user_id, :integer         # Hidden
  #     configure :creator_id, :integer         # Hidden
  #     configure :updator_id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model SRV do
  #   # Found associations:
  #     configure :domain, :belongs_to_association
  #     configure :user, :belongs_to_association
  #     configure :creator, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer
  #     configure :domain_id, :integer         # Hidden
  #     configure :name, :string
  #     configure :type, :string
  #     configure :content, :string
  #     configure :ttl, :integer
  #     configure :prio, :integer
  #     configure :change_date, :integer
  #     configure :authentication_token, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :user_id, :integer         # Hidden
  #     configure :creator_id, :integer         # Hidden
  #     configure :updator_id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model TXT do
  #   # Found associations:
  #     configure :domain, :belongs_to_association
  #     configure :user, :belongs_to_association
  #     configure :creator, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer
  #     configure :domain_id, :integer         # Hidden
  #     configure :name, :string
  #     configure :type, :string
  #     configure :content, :string
  #     configure :ttl, :integer
  #     configure :prio, :integer
  #     configure :change_date, :integer
  #     configure :authentication_token, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :user_id, :integer         # Hidden
  #     configure :creator_id, :integer         # Hidden
  #     configure :updator_id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model User do
  #   # Found associations:
  #     configure :creator, :belongs_to_association
  #     configure :domains, :has_many_association
  #     configure :records, :has_many_association
  #     configure :permissions, :has_many_association
  #     configure :permitted_domains, :has_many_association   #   # Found columns:
  #     configure :id, :integer
  #     configure :email, :string
  #     configure :password, :password         # Hidden
  #     configure :password_confirmation, :password         # Hidden
  #     configure :reset_password_token, :string         # Hidden
  #     configure :reset_password_sent_at, :datetime
  #     configure :remember_created_at, :datetime
  #     configure :sign_in_count, :integer
  #     configure :current_sign_in_at, :datetime
  #     configure :last_sign_in_at, :datetime
  #     configure :current_sign_in_ip, :string
  #     configure :last_sign_in_ip, :string
  #     configure :confirmation_token, :string
  #     configure :confirmed_at, :datetime
  #     configure :confirmation_sent_at, :datetime
  #     configure :unconfirmed_email, :string
  #     configure :failed_attempts, :integer
  #     configure :unlock_token, :string
  #     configure :locked_at, :datetime
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :full_name, :string
  #     configure :creator_id, :integer         # Hidden
  #     configure :updator_id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
end
