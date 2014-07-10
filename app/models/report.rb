class Report < ActiveRecord::Base
  include JsonSerializingModel
  attr_accessible :summary, :date, :complete, :assigned_parts, :assigned_tasks, :unused_parts, :completed_parts, :incomplete_tasks, :completed_tasks, :company, :complete?, :hours, :days_worked, :manager

  belongs_to :user
  belongs_to :project
  belongs_to :client
  has_many :locations_reports
  has_many :locations, :through => :locations_reports
  has_many :users_reports
  has_many :users, :through => :user_reports
  has_many :report_tasks, :through => :users_reports
  has_many :report_parts, :through => :users_reports
  has_many :tasks
  has_many :parts

  def manager
    @manager ||= self.user
  end

  def employee_reports(employee)
    users_reports.where(:report_id => self.id, :user_id => employee.id)
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

  def employees
    @employees = []
    users_reports.each { |u_r| @employees << u_r.user }
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
    users_reports.each { |u_r| @hours += u_r.hours }
    @hours
  end

  def employee_days_worked
    @employee_days_worked = 0
    h = {}
    users_reports.each { |u_r| h[[u_r.employee.id, u_r.date]] = true }
    h.each { |k, v| @employee_days_worked += 1 }
    @employee_days_worked
  end

  def get_reports(options = {})
    if options["employee"].present?
      rep = employee_reports(get_employee(options["employee"]))
    else
      rep = users_reports
    end
    rep
  end

  def completed_reports
    get_reports(options).where(:completed => true) || []
  end

  def complete?
    @complete ||= if self.complete
      true
    elsif (self.users_reports.where(:complete => true))
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