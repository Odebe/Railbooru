class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #user ||= User.new # guest user (not logged in)
    if user.nil?
      can :read, [Post, Tag, Comment, Pool, TagAlias]
    elsif user.admin_role?
      can :manage, :all
    else
      can [:read, :create], [Post, Tag, Comment]
      can [:destroy], Post, user_id: user.id
      can [:update], Post
      can [:destroy], Comment, user_id: user.id
      can [:read], User, id: user.id
      can [:read, :create], Pool
      can [:update], Pool, user_id: user.id
      can [:read], TagAlias
      #can :manage, []
    end

    #if user.admin_role?
    #  can :manage, :all
    #else
    #  can :read, [:posts, :tags]
    #end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
