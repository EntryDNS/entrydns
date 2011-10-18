class Ability
  include CanCan::Ability
  attr_accessor :user
  attr_accessor :context

  def initialize(options)
    @user = options[:user] || User.new
    @context = options[:context] || :application
    
    if user.persisted?
    
      # can manage his domains and records
      can :manage, Domain, :user_id => user.id
      can :manage, Record, :domain => {:user_id => user.id}
      cannot :delete, SOA # it's deleted with the parent domain
      
      # can manage his hosts
      can :manage, A, :user_id => user.id #, :domain => {:name => Settings.host_domains}
      
    end

    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
