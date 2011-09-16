class Ability
  include CanCan::Ability

  def initialize(user)

    if user.role_yavdr?
      can :manage, :all
    elsif user.role_logo?
      can :manage, Logo
    end
    
  end
end
