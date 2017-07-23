class Ability
  include CanCan::Ability

  def initialize user
    alias_action :update, :destroy, to: :modify
    alias_action :create, :modify, to: :full_acc
    return unless user

    user_id = user.id
    can :read, :all
    can [:full_acc], Post, user_id: user_id
    can [:full_acc], Comment, user_id: user_id
    can [:search], Post
    can [:following, :followers], User
    if user.is_admin?
      can [:destroy], User
    end
  end
end
