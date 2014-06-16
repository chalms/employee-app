# class Ability
#   include CanCan::Ability

#   def initialize(user)
#     # Define abilities for the passed in user here. For example:
#     #
#     #   user ||= User.new # guest user (not logged in)
#     #   if user.admin?
#     #     can :manage, :all
#     #   else
#     #     can :read, :all
#     #   end
#     #
#     # The first argument to `can` is the action you are giving the user
#     # permission to do.
#     # If you pass :manage it will apply to every action. Other common actions
#     # here are :read, :create, :update and :destroy.
#     #
#     # The second argument is the resource the user can perform the action on.
#     # If you pass :all it will apply to every resource. Otherwise pass a Ruby
#     # class of the resource.
#     #
#     # The third argument is an optional hash of conditions to further filter the
#     # objects.
#     # For example, here the user can only update published articles.
#     #
#     #   can :update, Article, :published => true
#     #
#     # See the wiki for details:
#     # https://github.com/ryanb/cancan/wiki/Defining-Abilities
#     case user.role
#     when 'admin'
#       can :manage, :all
#     # when 'manager'
#     #   can :update, :read, Manager, :manager_id => user.id
#     #   can :create, Report 
#     #   can :read, :update, :destroy, Report, :manager_id => user.id
#     when 'worker'
#       can :read, User
#       # can :update, :read, Worker, :worker_id => user.id 
#       # can :read, Report, :active => true, :worker_id => user.id
#     else
#         can :manage, User
#     end
#   end
# end