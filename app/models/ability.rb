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
      can :manage, UserReport, :user => { :company => { :id => user.company.id }}
      can :manage, Report, :company => { :id => user.company.id }
      can :manage, ReportTask, :report => {:company => { :id =>  user.company.id }}
      can :manage, ReportPart, :report => {:company => { :id =>  user.company.id }}
      can :manage, Task, :report => { :company => {:id => user.company.id }}
      can :manage, Part, :company => { :id => user.company.id}
      can :manage, Location, :owner => { :company => {:id => user.company.id }}}
      can :manage, Chat, :company => {:id => user.company.id} 
      can :manage, UserMessage, :user => {:company => { :id => user.company.id }}
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
      can :manage, UserReport, :report => { :manager => {:id => user.id }} 
      can :manage, Report, :manager => { :id => user.id }
      can :manage, Task, :manager => { :id => user.id }
      can :manage, Part, :manager => { :id => user.id }
      can :manage, ReportTask, :report => { :manager => {:id => user.id }} , :task => { :company => { :id => user.id}}
      can :manage, ReportPart, :report => { :manager => {:id => user.id }} , :part => { :company => { :id => user.id}}
      can :destroy, Location, :owner => { :manager => { :id => user.id }}
      can [:read, :update, :create], Location, :owner => { :company => { :id => user.id}
      can [:create, :update, :read], Chat { |c| c.users.include? (user) }
      can [:create, :read], Message { |message| (message.group.include? user.id)  }
      can [:create, :update], UserMessage, :message => { :user => {:id => user.id}} 
      can [:create, :read], Photo 
    end 

    if (user.role? :employee) 
      can :read, User, { |u| user.managers.include?(u) }
      can [:update, :read], User, :id => user.id 
      can [:update, :read], UserReport, :employee =>  { :id => user.id }
      can [:update, :read], UserTask, :employee => { :id => user.id }
      can [:update, :read], UserPart, :employee => { :id => user.id }
      can [:update, :read], ReportTask, { |r_t| (user.reports.tasks.include? r_t.task) }
      can [:update, :read], ReportPart, { |r_p| (user.reports.parts.include? r_t.task) }
      can [:update, :read], Location, { |l| l.owner.report.employees.include? user } 
      can [:create, :update, :read], Chat, { |c| c.users.include? (user) }
      can [:create, :read, :update], Message { |message| (message.group.include? user.id)  }
      can [:read, :update], UserMessage, :message => { :user => {:id => user.id}} 
      can [:create, :read], Photo 
    end 
  end
end