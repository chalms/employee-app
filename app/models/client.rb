 class Client < ActiveRecord::Base
  include JsonSerializingModel
  has_many :clients_projects
  has_many :projects, :through => :clients_projects
  has_many :locations
  has_many :tasks
  has_many :parts
  belongs_to :company
  has_many :contacts
  belongs_to :user
  has_many :reports, :through => :projects
  attr_accessible :name, :manager, :complete, :assigned_parts, :assigned_tasks, :completed_parts, :completed_tasks, :company, :complete?, :hours, :employee_days_worked

  def manager
    @manager ||= user
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
    get_reports(options).each do |r|
      if (r.users_reports)
        r.users_reports do |u_r|
          h[[u_r.employee.id, u_r.date]] = true
        end
      end
    end
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
