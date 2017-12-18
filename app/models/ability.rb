class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :index, :show, :create, :destroy, to: :crud
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      if user.is_super_admin?
        can :manage, :all
      end
      if user.is_admin?
        can :manage, [Business, InsuranceType, Product], account_id: user.account_id
        can :crud, User, account_id: user.account_id
        can :update, User do |u|
          !u.is_super_admin?
        end
      end

      if user.is_broker?
        can :manage, [Business, InsuranceType], user_id: user.id
      end
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
