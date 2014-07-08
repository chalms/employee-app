 class Client < AcctiveRecord::Base
  include JsonSerializingModel

  attr_accessible :name, :manager, :complete, :assigned_parts, :assigned_tasks, :complete_parts, :complete_tasks, :company, :complete?, :hours, :days_worked
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
