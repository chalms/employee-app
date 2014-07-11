class Ability
  include CanCan::Ability
  def initialize(user)
    if user.role? :admin
      can :manage, :all
    end

    if user.role? :company_admin
      can :manage, Company, :company_admin => { :id  => user.id }
      can :manage, Client, :company =>  { :id => user.company.id }
      can :manage, Project, :company => { :id => user.company.id }
      can :manage, User, :company => { :id => user.company.id }
      can :manage, UsersReport, :user => { :company => { :id => user.company.id }}
      can :manage, Report, :company => { :id => user.company.id }
      can :manage, ReportsTask, :report => {:company => { :id =>  user.company.id }}
      can :manage, ReportsPart, :report => {:company => { :id =>  user.company.id }}
      can :manage, Task, :report => { :company => {:id => user.company.id }}
      can :manage, Part, :company => { :id => user.company.id}
      can :manage, Location, :owner => { :company => {:id => user.company.id }}}
      can :manage, Chat, :company => {:id => user.company.id}
      can :manage, UsersMessage, :user => {:company => { :id => user.company.id }}
      can :manage, Message, :chat => { :company => {:id => user.company.id }}
      can :manage, Photo
    end

    if user.role? :manager
      can :read, Company, :id => user.company.id
      can [:read, :update], Client, :company => { :id => user.company.id }
      can [:create, :delete], Client { |c| c.try(:managers).include? user }
      can [:read, :update] Project
      can [:create, :delete, :update], Project, :manager => {:id => user.id}
      can :read, User { |u| ((u.try(:company).id == user.company.id) && (u.role?(:company_admin) == false)); }
      can :manage, UsersReport, :report => { :manager => {:id => user.id }}
      can :manage, Report, :manager => { :id => user.id }
      can :manage, Task, :manager => { :id => user.id }
      can :manage, Part, :manager => { :id => user.id }
      can :manage, ReportsTask, :report => { :manager => {:id => user.id }} , :task => { :company => { :id => user.id}}
      can :manage, ReportsPart, :report => { :manager => {:id => user.id }} , :part => { :company => { :id => user.id}}
      can :destroy, Location, :owner => { :manager => { :id => user.id }}
      can [:read, :update, :create], Location, :owner => { :company => { :id => user.id}
      can [:create, :update, :read], Chat { |c| c.users.include? (user) }
      can [:create, :read], Message { |message| (message.group.include? user.id)  }
      can [:create, :update], UsersMessage, :message => { :user => {:id => user.id}}
      can [:create, :read], Photo
    end

    if (user.role? :employee)
      can :read, User, { |u| user.managers.include?(u) }
      can [:update, :read], User, :id => user.id
      can [:update, :read], UsersReport, :employee =>  { :id => user.id }
      can [:update, :read], ReportsTask, { |r_t| (user.reports.tasks.include? r_t.task) }
      can [:update, :read], ReportsPart, { |r_p| (user.reports.parts.include? r_t.task) }
      can [:update, :read], Location, { |l| l.owner.report.employees.include? user }
      can [:create, :update, :read], Chat, { |c| c.users.include? (user) }
      can [:create, :read, :update], Message { |message| (message.group.include? user.id)  }
      can [:read, :update], UsersMessage, :message => { :user => {:id => user.id}}
      can [:create, :read], Photo
    end
  end
end