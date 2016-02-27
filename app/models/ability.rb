class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user && user.admin?
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard           
      can :manage, :all
    else
      can :read, :all 
  end
end
