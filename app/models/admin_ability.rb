class AdminAbility
  include CanCan::Ability

  def initialize(admin)
    can :access, :rails_admin
    can :manage, :all
    cannot [:ban, :unban], :all
    can [:ban, :unban], User
  end
end
