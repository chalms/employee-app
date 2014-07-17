 class Project < ActiveRecord::Base
  attr_accessible  :name, :start_date, :end_date, :budget, :complete, :assigned_parts, :assigned_tasks, :completed_parts, :completed_tasks, :company_id, :complete?, :hours, :days_worked, :manager_number, :clients, :managers, :employees, :manager
  belongs_to :company
  has_many :reports
  has_many :tasks
  has_many :parts
  has_many :users, :through => :reports
  has_many :contacts, :through => :users
  has_many :clients_projects
  has_many :clients, :through => :clients_projects

  def manager
    num = ((self.manager_number) || (self.manager_id))
    if num
      @manager = User.find(num)
    elsif (users.where(role: 'manager').count > 0)
      @manager = users.where(role: 'manager').first
    else
      @manager = nil
    end
    @manager
  end

  def employees
    @employees ||= users.where(type: 'Employee')
  end

  def managers
    @managers ||= users.where(type: 'Manager')
  end

  def assigned_tasks(options = {})
    @assigned_tasks = []
    get_reports(options).each { |r| @assigned_tasks += r.assigned_tasks(options) }
    @assigned_tasks
  end

  def assigned_parts(options = {})
    @assigned_parts = []
    get_reports(options).each { |r| @assigned_parts += r.assigned_parts(options) }
    @assigned_parts
  end

  def assigned_reports(options = {})
    @assigned_reports = []
    get_reports(options).each { |r| @assigned_reports << r if (r.assigned_tasks(options).count > 0)}
    @assigned_reports
  end

  def completed_reports(options = {})
    get_reports(options).where(complete: :true)
  end

  def completed_tasks(options = {})
    @completed_tasks = []
    get_reports(options).each { |r| @completed_tasks += r.completed_tasks(options) }
    @completed_tasks
  end

  def completed_parts(options = {})
    @completed_parts = []
    get_reports(options).each { |o| @completed_parts += o.completed_parts(options) }
    @completed_parts
  end

  def tasks_completion_percent(options = {})
    @tasks_completion_percent = ((assigned_tasks(options).length.to_f / completed_tasks(options).length.to_f) * 100).round(2)
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

  def days_worked(options = {})
    @days_worked = 0
    h = {}
    get_reports(options).each do |r|
      if (r.andand.users_reports)
        r.users_reports do |u_r|
          h[[u_r.employee.id, u_r.date]] = true
        end
      end
    end
    h.each { |k, v| @days_worked += 1 }
    @days_worked
  end

  def get_reports(options = {})
    if (options["manager"])
      rep = manager(options["manager"]).reports.where(:project_id => self.id)
    elsif (options["employee"])
      rep = employee(options["employee"]).reports.where(:project_id => self.id)
    else
      rep = self.reports
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