
    class Company < ActiveRecord::Base
      include JsonSerializingModel

      attr_accessible :name, :admin, :reports 
      has_many :users, :as => :managers 
      has_many :users, :as => :employees 
      has_one :contact 
      has_many :projects 
      has_many :parts 
      has_many :tasks 
      has_many :clients


      def admin=(admin_id)
        a = User.where(id: admin_id).andand.first 
        raise Exceptions::StdError, "User is not an administrator" unless (a.role == 'company_admin')
        self.update_attributes(:company_admin => admin_id)
        @admin = a
      end 

      def admin
        @admin ||= self.company_admin
      end 

      def manager(manager_id)
        manager = User.where(id: manager_id).andand.first 
        raise Exceptions::StdError, "User is not a manager" unless (manager.role == 'manager')
        managers.where(id: manager.id).first_or_create 
      end 

      def employee(employee_id)
        employee = User.where(id: employee_id).andand.first 
        raise Exceptions::StdError, "User is not an employee" unless (employee.role == 'employee')
        employees.where(id: employee.id).first_or_create
      end 

      def client(client_id) 
        c = Client.where(id: client_id).andand.first 
        raise Exceptions::StdError, "Client does not exist" unless (c.present?)
        self.update_attributes(:client => c)
      end

      def task(task_id)
        t = Task.where(id: task_id).andand.first
        raise Exceptions::StdError, "Task does not exist" unless t 
        tasks.where(:task => t).first_or_create
      end 

      def part(part_id)
        p = Part.where(id: part_id).andand.first 
        raise Exceptions::StdError, "Part does not exist" unless p 
        parts.where(:part => p).first_or_create 
      end 

      def reports 
        Reports.where('company = ?', self)
      end 

      def assigned_tasks(options = {})
        @assigned_tasks = []
        get_reports(options).each { |r| @assigned_tasks += r.assigned_tasks }
        @assigned_tasks 
      end 

      def assigned_parts(options = {})
        @assigned_parts = []
        get_reports(options).each { |r| @assigned_parts += r.assigned_parts }
        @assigned_parts 
      end

      def assigned_reports(options = {})
        @assigned_reports = []
        get_reports(options).each { |r| @assigned_reports += r if (r.assigned_tasks.count > 0)}
        @assigned_reports
      end 

      def completed_reports(options = {})
        get_reports(options).where(completed :true)
      end 

      def completed_tasks(options = {})
        @completed_tasks = []
        get_reports(options).each { |r| @completed_tasks += r.completed_tasks } 
        @completed_tasks 
      end 

      def completed_parts(options = {})
        @completed_parts = []
        get_reports(options).each { |o| @completed_parts += o.completed_parts }
        @completed_parts
      end 

      def tasks_completion_percent(options = {})
        @tasks_completion_percent = ((assigned_tasks(options).count.to_f / completed_tasks(options).count.to_f) * 100).round(2)
      end 

      def parts_completion_percent(options = {})
        @parts_completeion_percent = ((assigned_parts(options).count.to_f / completed_parts(options).count.to_f) * 100).round(2)
      end 

      def reports_completion_percent(options = {})
        @reports_completion_percent = ((assigned_reports(options).count.to_f / completed_reports(options).count.to_f) * 100).round(2)
      end

      def hours(options = {})
        @hours = 0 
        get_reports(options).each { |r| @hours += r.hours } 
        @hours  
      end 

      def employee_days_worked(options = {})
        @days = 0
        get_reports(options).each { |r| @days += r.employee_days_worked }
        @days 
      end 

      def get_reports(options = {})
        if (options["manager"])
          rep = manager(options["manager"]).reports
        elsif (options["employee"])
          rep = employee(options["employee"]).reports
        else 
          rep = reports 
        end 

        if (options["upcoming"])
          return rep.where("date < ?", Date.new)
        elsif (options["today"])
          return rep.where("date = ?", Date.new)
        elsif (options["future"])
          return rep.where("date > ?", Date.new)
        else 
          return rep
        end 
      end

    end  

    class Project < ActiveRecord::Base 
      attr_accessible :name, :start_date, :end_date, :budget, :client
      belongs_to :company 
      has_many :reports
      has_many :parts
      has_many :locations, :through => { :reports, :tasks, :parts, :clients }
      has_many :tasks, 
      has_many :users, as: :employees 
      has_many :users, as: :managers
      has_many :contacts, :through => { :users }
      has_one :client 

      def manager(manager_id)
        manager = User.where(id: manager_id).andand.first 
        raise Exceptions::StdError, "User is not a manager" unless (manager.role == 'manager')
        managers.where(id: manager.id).first_or_create 
      end 

      def employee(employee_id)
        employee = User.where(id: employee_id).andand.first 
        raise Exceptions::StdError, "User is not an employee" unless (employee.role == 'employee')
        employees.where(id: employee.id).first_or_create
      end 

      def client(client_id) 
        c = Client.where(id: client_id).andand.first 
        raise Exceptions::StdError, "Client does not exist" unless (c.present?)
        self.update_attributes(:client => c)
      end

      def task(task_id)
        t = Task.where(id: task_id).andand.first
        raise Exceptions::StdError, "Task does not exist" unless t 
        tasks.where(:task => t).first_or_create
      end 

      def part(part_id)
        p = Part.where(id: part_id).andand.first 
        raise Exceptions::StdError, "Part does not exist" unless p 
        parts.where(:part => p).first_or_create 
      end 

      def report(report_id)
        r = Report.where(id: report_id).andand.first 
        raise Exceptions::StdError, "Report does not exist" unless r 
        reports.where(:report => r).first_or_create
      end 

      def assigned_tasks(options = {})
        @assigned_tasks = []
        get_reports(options).each { |r| @assigned_tasks += r.assigned_tasks }
        @assigned_tasks 
      end 

      def assigned_parts(options = {})
        @assigned_parts = []
        get_reports(options).each { |r| @assigned_parts += r.assigned_parts }
        @assigned_parts 
      end

      def assigned_reports(options = {})
        @assigned_reports = []
        get_reports(options).each { |r| @assigned_reports += r if (r.assigned_tasks.count > 0)}
        @assigned_reports
      end 

      def completed_reports(options = {})
        get_reports(options).where(completed :true)
      end 

      def completed_tasks(options = {})
        @completed_tasks = []
        get_reports(options).each { |r| @completed_tasks += r.completed_tasks } 
        @completed_tasks 
      end 

      def completed_parts(options = {})
        @completed_parts = []
        get_reports(options).each { |o| @completed_parts += o.completed_parts }
        @completed_parts
      end 

      def tasks_completion_percent(options = {})
        @tasks_completion_percent = ((assigned_tasks(options).count.to_f / completed_tasks(options).count.to_f) * 100).round(2)
      end 

      def parts_completion_percent(options = {})
        @parts_completeion_percent = ((assigned_parts(options).count.to_f / completed_parts(options).count.to_f) * 100).round(2)
      end 

      def reports_completion_percent(options = {})
        @reports_completion_percent = ((assigned_reports(options).count.to_f / completed_reports(options).count.to_f) * 100).round(2)
      end

      def hours(options = {})
        @hours = 0 
        get_reports(options).each { |r| @hours += r.hours } 
        @hours  
      end 

      def employee_days_worked(options = {})
        @employee_days_worked = 0
        h = {} 
        get_reports(options).user_reports.each { |u_r| h[[u_r.employee.id, u_r.date]] = true }
        h.each { |k, v| @employee_days_worked += 1 } 
        @employee_days_worked
      end 

      def get_reports(options = {})
        if (options["manager"])
          rep = manager(options["manager"]).reports.where(:project => self)
        elsif (options["employee"])
          rep = employee(options["employee"]).reports.where(:project => self)
        else 
          rep = reports 
        end 

        if (options["upcoming"])
          return rep.where("date < ?", Date.new)
        elsif (options["today"])
          return rep.where("date = ?", Date.new)
        elsif (options["future"])
          return rep.where("date > ?", Date.new)
        else 
          return rep
        end 
      end
    end 

    class Client < AcctiveRecord::Base
      include JsonSerializingModel

      attr_accessible :name, :manager 
      belongs_to :company
      has_many :locations 
      has_many :projects
      has_many :reports, :through => { :projects }
      has_many :tasks
      has_many :parts 
      has_one :manager 
      has_many :contacts 

      def manager(manager_id)
        manager = User.where(id: manager_id).andand.first 
        raise Exceptions::StdError, "User is not a manager" unless (manager.role == 'manager')
        managers.where(id: manager.id).first_or_create 
      end 

      def task(task_id)
        t = Task.where(id: task_id).andand.first
        raise Exceptions::StdError, "Task does not exist" unless t 
        tasks.where(:task => t).first_or_create
      end 

      def part(part_id)
        p = Part.where(id: part_id).andand.first 
        raise Exceptions::StdError, "Part does not exist" unless p 
        parts.where(:part => p).first_or_create 
      end 

      def report(report_id)
        r = Report.where(id: report_id).andand.first 
        raise Exceptions::StdError, "Report does not exist" unless r 
        reports.where(:report => r).first_or_create
      end 

      def project(project_id)
        p = Project.where(id: project_id).andand.first 
        raise Exceptions::StdError, "Project does not exist" unless p 
        projects.where(:project => p).first_or_create
      end 

      def contact(contact_id)
        c = Contact.where(id: contact_id).andand.first 
        raise Exceptions::StdError, "Contact does not exist" unless c 
        contacts.where(:company => c).first_or_create
      end 

      def assigned_tasks(options = {})
        @assigned_tasks = []
        get_reports(options).each { |r| @assigned_tasks += r.assigned_tasks }
        @assigned_tasks 
      end 

      def assigned_parts(options = {})
        @assigned_parts = []
        get_reports(options).each { |r| @assigned_parts += r.assigned_parts }
        @assigned_parts 
      end

      def assigned_reports(options = {})
        @assigned_reports = []
        get_reports(options).each { |r| @assigned_reports += r if (r.assigned_tasks.count > 0)}
        @assigned_reports
      end 

      def completed_reports(options = {})
        get_reports(options).where(completed :true)
      end 

      def completed_tasks(options = {})
        @completed_tasks = []
        get_reports(options).each { |r| @completed_tasks += r.completed_tasks } 
        @completed_tasks 
      end 

      def completed_parts(options = {})
        @completed_parts = []
        get_reports(options).each { |o| @completed_parts += o.completed_parts }
        @completed_parts
      end 

      def tasks_completion_percent(options = {})
        @tasks_completion_percent = ((assigned_tasks(options).count.to_f / completed_tasks(options).count.to_f) * 100).round(2)
      end 

      def parts_completion_percent(options = {})
        @parts_completeion_percent = ((assigned_parts(options).count.to_f / completed_parts(options).count.to_f) * 100).round(2)
      end 

      def reports_completion_percent(options = {})
        @reports_completion_percent = ((assigned_reports(options).count.to_f / completed_reports(options).count.to_f) * 100).round(2)
      end

      def hours(options = {})
        @hours = 0 
        get_reports(options).each { |r| @hours += r.hours } 
        @hours  
      end

      def employee_days_worked(options = {})
        @employee_days_worked = 0
        h = {} 
        get_reports(options).user_reports.each { |u_r| h[[u_r.employee.id, u_r.date]] = true }
        h.each { |k, v| @employee_days_worked += 1 } 
        @employee_days_worked
      end 

      def get_reports(options = {})
        if (options["manager"])
          rep = manager(options["manager"]).reports
        elsif (options["employee"])
          rep = reports.get_reports(options["employee"])
        else 
          rep = reports 
        end 

        if (options["upcoming"])
          return rep.where("date < ?", Date.new)
        elsif (options["today"])
          return rep.where("date = ?", Date.new)
        elsif (options["future"])
          return rep.where("date > ?", Date.new)
        else 
          return rep
        end 
      end
    end 

    class User < ActiveRecord::Base
      include JsonSerializingModel

      attr_accessible :email, :name, :password_digest, :employee_number, :hours, :days_worked
      belongs_to :company 
      has_one :contact 
      has_many :user_reports
      has_and_belongs_to_many :chats
      has_many :messages, :through => :chats

      before_create :valid_employee_id?
      validate :valid_employee_id?

      def company=(comp)
        @company = Company.find(id: comp) unless comp.is_a? Company 
        raise Exceptions::StdError, "Invalid Company!" unless @company.andand.present? 
        @company
      end 

      def valid_employee_id?
        emp = company.employee_logs.find_by_employee_number(employee_number)
        raise Exceptions::StdError, "Not a valid employee id for that company!" unless (emp.andand.present?)
        raise Exceptions::StdError, "Invalid employee permissions to use this feature!" if (emp.role != role) 
        true 
      end 

      def hours(options = {})
        @hours = 0 
        return @hours unless (self.role == 'employee')
        get_user_report(options).each { |u_r| @hours += u_r.hours }
        @hours 
      end 

      def days_worked(options = {})
        @days_worked = 0 
        h = {} 
        return @days_worked unless (self.role == 'employee')
        get_user_report(options).each { |u_r| h[u_r.date] = true }
        h.each { |k, v| @days_worked += 1 }
        @days_worked
      end

      def assigned_tasks(options = {})
        @assigned_tasks = []
        get_user_reports(options).each {|u_r| @assigned_tasks += u_r.assigned_tasks}
        @assigned_tasks
      end 

      def completed_tasks(options = {})
        @completed_tasks = []
        get_user_reports(options).each {|u_r| @completed_tasks += u_r.completed_tasks}
        @completed_tasks
      end 

      def assigned_parts(options = {})
        @assigned_parts = []
        get_user_reports(options).each {|u_r| @assigned_parts += u_r.assigned_parts}
        @assigned_parts
      end 

      def completed_parts(options = {})
        @completed_parts = []
        get_user_reports(options).each {|u_r| @completed_parts += u_r.completed_parts}
        @completed_parts
      end 

      def tasks_completion_percent(options = {})
        @tasks_completion_percent = ((assigned_tasks(options).count.to_f / completed_tasks(options).count.to_f) * 100).round(2)
      end 

      def parts_completion_percent(options = {})
        @parts_completeion_percent = ((assigned_parts(options).count.to_f / completed_parts(options).count.to_f) * 100).round(2)
      end 

      def reports_completion_percent(options = {})
        @reports_completion_percent = ((assigned_reports(options).count.to_f / completed_reports(options).count.to_f) * 100).round(2)
      end

      def get_user_reports(options = {})
        if (options["before"])
          user_reports.where('date < ?', Date.new)
        elsif (options["today"])
          user_reports.where('date = ?', Date.new)
        elsif (options["future"])
          user_reports.where('date > ?', Date.new)
        else 
          user_reports 
        end 
      end 
    end

    class Report < ActiveRecord::Base
      include JsonSerializingModel
      attr_accessible :summary, :date, :complete, :assigned_parts,
        :assigned_tasks, :unused_parts, :used_parts, :incomplete_tasks,
        :complete_tasks, :company, :complete?

      belongs_to :user, :as => :manager 
      has_many :users, :as => :employees

      has_many :user_reports

      has_and_belongs_to_many :tasks
      has_and_belongs_to_many :parts

      def employee_reports(employee)
        user_reports.where(:report_id => self.id, :user_id => employee.id)
      end 

      def report_for_user(employee)
        employee_reports(employee).find_or_create
      end 

      def assign_task(employee_id, task_id) 
        report_for_user(get_employee(employee_id)).add_task(task_id)
      end 

      def assign_part(employee_id, part_id)
        report_for_user(get_employee(employee_id)).add_part(part_id)
      end 

      def get_employee(employee_id)
        employee = User.find(id: employee_id, company: company)
        if (employee.present?)
          return employee
        else 
          raise Exceptions::StdError, "Employee does not exist"
        end  
      end 

      def assigned_parts(options = {})
        @assigned_parts = []
        get_reports(options).each { |u_r| @assigned_parts += u_r.parts }
        @assigned_parts 
      end 

      def assigned_tasks(options = {})
        @assigned_tasks = []
        get_reports(options).each { |u_r| @assigned_tasks += u_r.tasks }
        @assigned_tasks 
      end 

      def incomplete_parts(option = {})
        @unused_parts = []
        get_reports(options).each { |u_p| @unused_parts += u_p.parts.where(used: false)}
        @unused_parts
      end 

      def complete_parts(options = {})
        @used_parts = []
        get_reports(options).each { |u_r| @used_parts += u_r.parts.where(used: true) }
        @used_parts 
      end

      def incomplete_tasks(options = {})
        @incomplete_tasks = []
        get_reports(options).each { |u_r| @incomplete_tasks += u_r.tasks.where(complete: false) }
        @incomplete_tasks 
      end 

      def complete_tasks(options = {})
        @completed_tasks = []
        get_reports(options).each { |u_r| @completed_tasks += u_r.tasks.where(completed: true) }
        @completed_tasks 
      end

      def hours 
        @hours = 0
        user_reports.each { |u_r| @hours += u_r.hours } 
        @hours 
      end

      def employee_days_worked 
        @employee_days_worked = 0
        h = {} 
        user_reports.each { |u_r| h[[u_r.employee.id, u_r.date]] = true }
        h.each { |k, v| @employee_days_worked += 1 } 
        @employee_days_worked
      end 

      def get_reports(options = {})
        if options["employee"].present? 
          rep = employee_reports(get_employee(options["employee"]))
        else 
          rep = user_reports
        end 
        rep 
      end 

      def completed_reports 
        get_reports(options).where(:completed => true) || []
      end 

      def complete? 
        @complete ||= if self.complete 
          true
        elsif (self.user_reports.where(:complete => true))
          self.update_attributes(:complete => true)
          true 
        else 
          false 
        end
      end 

      def company
        @company ||= manager.company 
      end 
    end 

    class Task < ActiveRecord::Base
      include JsonSerializingModel

      belongs_to :manager 
      belongs_to :company
      has_and_belongs_to_many :projects
      has_and_belongs_to_many :reports
      has_and_belongs_to_many :user_reports 
      attr_accessible :description
    end 

    class Part < ActiveRecord::Base
      include JsonSerializingModel
      belongs_to :company
      belongs_to :manager
      has_and_belongs_to_many :projects
      has_and_belongs_to_many :reports
      has_and_belongs_to_many :user_reports 

      attr_accessible :barcode, :name
    end 

    class Contact < ActiveRecord::Base
      include JsonSerializingModel
      attr_accessible :phone, :email, :name 
      belongs_to :company 
      belongs_to :user 

      validate :validator 
      attr_accessible :owner 

      def validator
        if (company || user)
          return true 
        else 
          raise Exceptions::StdError, "Contact has no owner"
          return false 
        end 
      end 

      def owner=(own)
        if ((own.is_a? Company) || (own.is_a? User))
          @owner = own
        end 
      end 

      def owner 
        @owner ||= (company || user)
      end 
    end 

    class Location < ActiveRecord::Base
      include JsonSerializingModel
      belongs_to :task
      belongs_to :report 
      belongs_to :part
      belongs_to :client 

      validate :validator
      attr_accessible :owner 

      def validator
        if (company || user || task || part)
          return true 
        else 
          raise Exceptions::StdError, "Location has no owner"
          return false 
        end  
      end 

      def owner=(own)
        if ((own.is_a? Company) || (own.is_a? User))
          @owner = own
        end 
      end 

      def owner 
        @owner ||= (company || user)
      end
    end 

    class Photo < ActiveRecord::Base 
      include JsonSerializingModel
      attr_accessible :data, :owner 

      belongs_to :report_part 
      belongs_to :report_task 
      belongs_to :message 

      validate :has_one_owner?

      def has_one_owner? 
        raise Exceptions::StdError, "Photo cannot have multiple owners" unless (report_part ^ report_task ^ message)
      end 

      def owner=(o)
        if (o)
          @owner = o 
        end 
      end

      def owner
        has_one_owner?
        @owner ||= do 
          if (self.message)
            @owner = message
          elsif (self.report_part)
            @owner = report_part 
          elsif (self.report_task)
            @owner = report_task
          end 
        end 
      end 
    end 


    class ReportPart < ActiveRecord::Base
      include JsonSerializingModel
      has_one :part 
      belongs_to :user_report 
      has_many :photos
      has_one :location, as: :owner 

      attr_accessible :complete, :note, :completion_time, :manager

      def self.manager 
        @manager ||= user_report.manager 
      end 
    end 

    class ReportTask < ActiveRecord::Base
      include JsonSerializingModel
      belongs_to :task 
      belongs_to :user_report
      has_many :photos 
      has_one :location, as: :owner
      has_many :parts 

      attr_accessible :complete, :note, :completion_time, :manager

      def self.manager 
        @manager ||= user_report.manager 
      end
    end 


    class UserReport < ActiveRecord::Base
      include JsonSerializingModel
      attr_accessible :complete, :checkin, :checkout, :parts, :tasks, :location, :date, :hours 
      belongs_to :report 
      belongs_to :user, as: :employee, :foreign_key => 'user_id'
      belongs_to :user, as: :manager, :foreign_key => 'user_id'
      has_many :report_parts 
      has_many :report_tasks 

      def hours
        @hours = 0 
        return @hours unless (checkin.present? && checkout.present?)
        @hours = (checkin - checkout)/1.hour 
      end 

      def parts 
        report_parts 
      end 

      def tasks
        report_tasks
      end 

      def add_report_task(report_task)
        report_tasks.where(id: report_tasks.id).first_or_create 
      end 

      def add_report_part(report_part)
        report_parts.where(id: report_parts.id).first_or_create 
      end 

      def add_task(task_id) 
        return report_tasks.where(task_id: task_id).first_or_create
      end 

      def add_part(part_id)
        return report_parts.where(part_id: part_id).first_or_create
      end

      def incomplete_parts 
        return report_parts.where(:complete => false)
      end 

      def incomplete_tasks 
        return report_tasks.where(:complete => false)
      end 

      def self.completed_parts 
        return report_parts.where(:complete => true)
      end 

      def self.completed_tasks 
        return report_tasks.where(:complete => true)
      end 

      def self.complete? 
        @complete ||= do 
          if (report_parts.where(:complete => false) && report_tasks.where(:complete => false))
            false 
          else 
            self.update_attributes(:complete => true)
            true 
          end 
        end 
      end 
    end

    class Chat 
      include JsonSerializingModel
      belongs_to :company 
      has_and_belongs_to_many :users 
      has_many :messages 

      validate :multi_user_unique 

      def multi_user_unique 
        raise Exceptions::StdError, "Something went wrong, hold on [for developers -> chat: no company id]" unless Company.find_by_id(company.id).present?
        raise Exceptions::StdError, "Something went wrong, hold on [for developers -> chat: duplicate chat with same users]" if (Chat.where(:company => company).count > 1) 
        raise Exceptions::StdError, "Chat needs at least two users" if (users.count < 2)
        return true 
      end

      def get_messages
        messages.order_by(:created_at, "DESC")
      end

      def send_message(message_text, message_photo, user_id)
        message_hash = {}
        message_hash[:text] = message_text 

        message = Message.new(sender: user, group: users)
        message.data = message_text 
        message.photo = Photo.create!(:data => message_photo, :message => message) if (message_photo.andand.present?)

        message.create!()
      end
    end 

    class Message  < ActiveRecord::Base
      include JsonSerializingModel
      has_one :photo
      has_one :user, as: :sender 
      has_many :users, as: :group 
      attr_accessible :data, :recipients, :sender, :created_at, :read_by_all

      before_create :set_recipients 

      def set_recipients
        unless @recipients 
          UserMessage.create!(:user => sender, :message => self, :read => true)
          @recipients = group.where('id != ?', sender.id)
          @recipients.each { |r| UserMessage.create!(:user => r, :message => self)} 
        end 
      end 

      def read_by_all 
        unless @read_by_all 
          lock = true 
          @recipients.each { |r| lock = false unless (UserMessage.where(:user => r, :message => self).first_or_create.read) } 
          @read_by_all = lock 
        end 
      end 
    end 

    class UserMessage  < ActiveRecord::Base
      include JsonSerializingModel
      belongs_to :message 
      belongs_to :user

      attr_accessible :read
    end 
