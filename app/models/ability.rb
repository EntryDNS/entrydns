class Ability
  CRUD = [:read, :create, :update, :destroy]
  
  include CanCan::Ability
  attr_accessor :user
  attr_accessor :context

  # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  def initialize(options)
    @user = options[:user] || User.new
    @context = options[:context] || :application
    
    action_aliases
    if user.persisted?
      owner_abilities
      sharing_abilities
    end
  end
  
  protected
  
  def owner_abilities
    # can manage his domains and records
    can CRUD, Domain, :user_id => user.id
    can CRUD, Record, :domain => {:user_id => user.id}
    cannot :delete, SOA # it's deleted with the parent domain
      
    # can manage his hosts
    can CRUD, A, :user_id => user.id #, :domain => {:name => Settings.host_domains}
      
    # can manage permissions for his domains
    can CRUD, Permission, :domain => {:user_id => user.id}
    can :crud_permissions, Domain, :user_id => user.id
  end
  
  def sharing_abilities
    # can manage shared domains and records
    can CRUD, Domain, :permissions.outer => {:user_id => user.id}
    can CRUD, Record, :domain => {:permissions.outer => {:user_id => user.id}}
      
    # can manage shared domains and records descendants
    for domain in user.permitted_domains
      can CRUD, Domain, :name_reversed.matches => "#{domain.name_reversed}.%" # descendants
      can CRUD, Record, :domain => {:name_reversed.matches => "#{domain.name_reversed}.%"} # descendant's
    end
  end
  
  def action_aliases
    alias_action :row, :show_search, :render_field, :to => :read
    alias_action :update_column, :add_association, :edit_associated, 
      :edit_associated, :new_existing, :add_existing, :to => :update
    alias_action :delete, :destroy_existing, :to => :destroy
  end
  
end
