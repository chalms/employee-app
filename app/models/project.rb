 class Project < ActiveRecord::Base 
  attr_accessible  :name, :start_date, :end_date, :budget, :complete, :assigned_parts, :assigned_tasks, :complete_parts, :complete_tasks, :company, :complete?, :hours, :days_worked
  belongs_to :company 
  has_many :reports
  has_many :parts
  has_many :locations, :through => [:reports, :tasks, :parts, :clients ]
  has_many :tasks
  has_and_belongs_to_many :users
  belongs_to :client 

  has_many :contacts, :through => :users

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

  def employees 
    @employees ||= users.where(role: 'employee')
  end 

  def managers 
    @managers ||= users.where(role: 'manager')
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
    get_reports(options).users_reports.each { |u_r| h[[u_r.employee.id, u_r.date]] = true }
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