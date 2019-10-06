class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Project
    can :manage, Task
    can :manage, Comment
  end
end
