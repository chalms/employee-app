class Company < ActiveRecord::Base
  include JsonSerializingModel

  attr_accessible :name, :admin, :reports, :complete, :assigned_parts, :assigned_tasks, :complete_parts, :complete_tasks, :complete?, :hours, :days_worked
  has_one :contact 
  has_many :projects 
  has_many :users
  has_many :parts 
  has_many :tasks 
  has_many :clients
  has_many :employee_logs

  def load_employee_logs(csv)
    # 
  end 

  def managers 
    users.where(role: 'manager')
  end

  def employees 
    users.where(role: 'employee')
  end 

  def admin=(admin_id)
    a = User.where(id: admin_id).andand.first 
    raise Exceptions::StdError, "User is not an administrator" unless (a.role == 'company_admin')
    self.update_attributes(:company_admin => admin_id)
    @admin = a
  end 

  def admin
    @admin ||= User.where(id: self.company_admin)
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

