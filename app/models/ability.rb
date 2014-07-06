class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role? :admin
      can :manage, :all
    end

    if user.role? :company_admin 
      can :manage, Company, :owner => { :id  => user.id } 
      can :manage, CompanyUser, :company => { :id => user.company.id }
      can :manage, CompanyClient, :company => { :id => user.company.id }
      can :manage, CompanyProject, :company => { :id => user.company.id }
      can :manage, CompanyPart, :company => { :id => user.company.id }
      can :manage, CompanyTask, :compant => { :id => user.company.id }
      can :manage, Client, :company =>  { :id => user.company.id } 
      can :manage, ClientReport, :report => { :company => {:id => user.company.id }}
      can :manage, ClientTask, :task => { :company => {:id => user.company.id }}
      can :manage, ClientPart, :part => {:company => {:id => user.company.id }}
      can :manage, ClientLocation, :client => { :company => {:id => user.company.id }}
      can :manage, ClientProject, :project => {:company => {:id => user.company.id}}
      can :manage, ClientManager, :manager => {:company => {:id => user.company.id}}
      can :manage, Project, :company => { :id => user.company.id }
      can :manage, ProjectReport, :report => { :company => {:id => user.company.id }}
      can :manage, ProjectTask, :task => {:company => {:id => user.company.id }}
      can :manage, ProjectPart, :part => {:company => {:id => user.company.id }}
      can :manage, ProjectManager, :project => {:company => {:id => user.company.id}}
      can :manage, ProjectEmployee, :project => {:company => {:id => user.company.id}}
      can :manage, ProjectLocation, :project => {:company => {:id => user.company.id}}
      can :manage, User, :company => { :id => user.company.id }
      can :manage, UserReport, :user => { :company => { :id => user.company.id }}
      can :manage, UserTask, :user => { :company => { :id => user.company.id }}
      can :manage, UserPart, :user => { :company => { :id => user.company.id }}
      can :manage, UserChat, :chat => { :company => {:id => user.company.id }} 
      can :manage, Report, :company => { :id => user.company.id }
      can :manage, ReportTask, :report => {:company => { :id =>  user.company.id }}
      can :manage, ReportPart, :report => {:company => { :id =>  user.company.id }}
      can :manage, ReportLocation, :report => {:company => { :id =>  user.company.id }}
      can :manage, Task, :report => { :company => {:id => user.company.id }}
      can :manage, TaskPart, :part => { :company => {:id => user.company.id }}
      can :manage, TaskLocation, :part => { :company => {:id => user.company.id }}
      can :manage, Part, :company => { :id => user.company.id}
      can :manage, PartLocation, :part => { :company => {:id => user.company.id }}
      can :manage, Location, :owner => { :company => {:id => user.company.id }}}
      can :manage, Chat, :company => {:id => user.company.id} 
      can :manage, ChatMessage, :chat => { :company => { :id => user.company.id } } 
      can :manage, Message, :chat => { :company => {:id => user.company.id }}
    end 
    if user.role? :manager 
      can :read, Company, :id => user.company.id
      can [:read, :update], CompanyClient, :company => { :id => user.company.id }
      can [:create, :delete], CompanyClient, :client => { :manager => {:id => user.id }
      can [:read, :update], CompanyProject, :company => { :id => user.company.id }
      can [:create, :delete],  CompanyProject, :project => { :manager => {:id => user.id }
      can [:read, :update], CompanyPart, :company => { :id => user.company.id }
      can [:create, :delete], CompanyPart, :part => { :manager => {:id => user.id } }
      can [:read, :update], CompanyTask, :company => { :id => user.company.id }
      can [:create, :delete], CompanyTask, :task => { :report => { :manager => {:id => user.id }}}
      can [:read, :update], Client, :company => { :id => user.company.id }
      can [:create, :delete], Client { |c| c.try(:managers).include? user }
      can [:read, :update], ClientProject, :project =>  { :company => { :id => user.company.id }}
      can [:create, :delete],  ClientProject { |c_p| c_p.project.try(:managers).include? (user) } 
      can [:read, :update], ClientPart, :client => { :company => { :id => user.company.id }} 
      can [:create, :delete], ClientPart  { |c_p|  c_p.client.try(:managers).include? user }
      can [:read, :update], ClientTask, :client => { :company => { :id => user.company.id }}
      can [:create, :delete], ClientTask { |c_t| c_t.client.try(:managers).include? user }
      can :read, ClientManager, :manager => { :company => { :id => user.company.id }}
      can [:update, :create], ClientManager { |c_m| c_m.client.try(:managers).include? (user) }
      can :read, ClientLocation, :client => { :company => { :id => user.company.id }}
      can [:update, :create], ClientLocation { |c_l|  c_l.client.try(:managers).include? (user) }
      can [:read, :update] Project 
      can [:create, :delete, :update], Project, :manager => {:id => user.id}
      can :read, ProjectReport, :project => {:company => {:id => user.company.id }}
      can [:update, :create, :delete],  ProjectReport, :project => {:manager => {:id => user.id }}
      can [:read, :update], ProjectTask, :project => {:company => {:id => user.company.id }}
      can [:create, :delete], ProjectPart, :project => {:manager => {:id => user.id }}
      can :read, ProjectManager, :project => {:company => {:id => user.company.id}}
      can [:update, :create, :delete], ProjectManager, :manager => {:id => user.id}
      can [:read, :update], ProjectEmployee, :project => {:company => {:id => user.company.id}}
      can [:create, :delete], ProjectEmployee, :project => {:manager => {:id => user.id }}
      can [:read, :update], ProjectLocation, :project => {:company => {:id => user.company.id}}
      can [:create, :delete], ProjectLocation, :project => {:manager => {:id => user.id }}
      can :read, User { |u| ((u.try(:company).id == user.company.id) && (u.role?(:company_admin) == false)); }
      can :manage, UserReport, :report => { :manager => {:id => user.id }} 
      can :manage, UserTask, :task => { :manager => { :id => user.id }} 
      can :manage, UserPart, :part => { :manager => { :id => user.id }}
      can :manage, UserChat, :user => { :id => user.id }
      can :manage, Report, :manager => { :id => user.id }
      can :manage, Task, :manager => { :id => user.id }
      can :manage, Part, :manager => { :id => user.id }
      can :manage, ReportTask, :report => { :manager => {:id => user.id }} , :task => { :company => { :id => user.id}}
      can :manage, ReportPart, :report => { :manager => {:id => user.id }} , :part => { :company => { :id => user.id}}
      can :manage, ReportLocation, :report => { :manager => {:id => user.id }}, :location => { :owner => { :company { :id => user.id}}}
      can :read, TaskPart, :task => { :company => {:id => user.company.id }}
      can [:create, :update, :destroy] TaskPart, :task => { :manager => {:id => user.id }}
      can :read, TaskLocation, :task => { :company => {:id => user.company.id }}
      can [:create, :read, :destroy] TaskLocation, :task => { :manager => { :id => user.id }}
      can :read, PartLocation, :part => { :company => {:id => user.company.id }}
      can [:create, :read, :destroy] PartLocation, :part => { :manager => { :id => user.id }}
      can :destroy, Location, :owner => { :manager => { :id => user.id }}
      can [:read, :update, :create], Location, :owner => { :company => { :id => user.id}
      can [:update, :read], Chat { |c| c.members.include? (user) }
      can [:create, :read, :update], ChatMessage { |c_m| c_m.chat.members.include? user }
      can [:create, :read, :update], Message { |message|  ((message.sender.try(:id) == user.id) || (message.recipient.try(:id) == user.id)) }
    end 
    if (user.role? :employee) 
      can :read, User, { |u| user.managers.include?(u) }
      can [:update, :read], User, :id => user.id 
      can [:update, :read], UserReport, :employee =>  { :id => user.id }
      can [:update, :read], UserTask, :employee => { :id => user.id }
      can [:update, :read], UserPart, :employee => { :id => user.id }
      can [:update, :read], ReportTask, { |r_t| (user.reports.tasks.include? r_t.task) }
      can [:update, :read], ReportPart, { |r_p| (user.reports.parts.include? r_t.task) }
      can [:update, :read], TaskPart,  { |t_p| t_p.report.employees.include? user }
      can [:update, :read], Location, { |l| l.owner.report.employees.include? user } 
      can [:update, :read, :create], TaskLocation { |t_l| t_l.task.report.employees.include? user }
      can [:update, :read, :create], PartLocation { |p_l| p_l.part.report.employees.include? user }
      can [:update, :read], Chat, { |c| c.members.include? (user) }
      can [:create, :read, :update], ChatMessage { |c_m| c_m.chat.members.include? user }
      can [:create, :read, :update], Message { |message| ((message.sender.try(:id) == user.id) || (message.recipient.try(:id) == user.id)) }
      end 
    end 
  end
end



      # contact: 
      #   t.string phone 
      #   t.string email 
      #   t.string name 

      # company_contact:  
      #   t.string company_id 
      #   t.string contact_id 

      # company_client: 
      #   t.string company_id 
      #   t.string client_id 

      # company: 
      #   t.string name 
      #   t.integer company_contact_id 
      #   t.integer company_client_id 
      #   t.integer company_project_id 
      #   t.integer company_part_id 
        

      # company_project: 
      #   t.integer company_id
      #   t.integer project_id 

      # company_part: 
      #   t.integer part_id
      #   t.integer company_id 

      # company_task: 
      #   t.integer task_id 
      #   t.integer company_id 