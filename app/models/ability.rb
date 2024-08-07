class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.member?
      can :read, Book
      can :create, Comment
      can :update, Comment, user_id: user.id
    else
      can :read, Book
    end
  end
end
