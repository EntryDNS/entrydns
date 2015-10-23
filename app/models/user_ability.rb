class UserAbility
  CRUD = [:read, :create, :update, :destroy]

  include CanCan::Ability
  attr_accessor :user
  attr_accessor :context

  # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  def initialize(user, options = {})
    @user = user || User.new
    @context = options[:context] || :application

    as_action_aliases
    action_aliases
    if @user.persisted?
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

    # can manage his authentications
    can CRUD, Authentication, :user_id => user.id
  end

  def sharing_abilities
    # can manage shared domains and records
    can CRUD, Domain, :permissions.outer => {:user_id => user.id}
    can CRUD, Record, :domain => {:permissions.outer => {:user_id => user.id}}

    # can manage shared domains and records descendants
    for domain in user.permitted_domains
      can CRUD, Domain, :name_reversed.matches => "#{domain.name_reversed}.%" # descendants
      can CRUD, Record, :domain => {:name_reversed.matches => "#{domain.name_reversed}.%"} # descendants
    end
  end

  def action_aliases
    alias_action :new_token, :to => :update
  end

end
