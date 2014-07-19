class Report < ActiveRecord::Base
  include JsonSerializingModel
  attr_accessible :summary, :date, :complete, :assigned_parts, :assigned_tasks, :unused_parts, :completed_parts, :incomplete_tasks, :completed_tasks, :company, :complete?, :hours, :days_worked, :manager, :manager_id, :user_id, :project_id, :id, :chat_id, :client_id
  belongs_to :user
  belongs_to :admin
  belongs_to :project
  belongs_to :client
  has_many :locations_reports
  has_many :locations, :through => :locations_reports
  has_many :users_reports
  has_many :users, :through => :users_reports
  has_many :report_tasks, :through => :users_reports
  has_many :report_parts, :through => :users_reports
  has_many :tasks
  has_many :parts
  has_one :chat
  after_create :create_chat
  TYPES = ['UsersReportsChat', 'ReportsChat']

  def create_chat
    chat = Chat.joins(:users_chats).where('user_id = ? OR user_id = ?', user.id, manager.id).andand.first
    unless !!chat
      chat = Chat.create!({:type => TYPES[1], :report_id => self.id})
      users.each do |u|
        user_chats = chat.users_chats.create!({:user_id => u.id})
        chat.users_chats.where({:chat_id => chat.id}).find_or_create
      end
      user.users_chats.where({:chat_id => chat.id}).first_or_create
      chat.users_chats.create!({:user_id => manager.id})
    end
    update_attribute(:chat_id, chat.id)
  end


  def add_tasks(ts = [])
    if (ts.is_a? Hash)
      ts = [tasks]
    end
    ts.each do |task_hash|
      if (task_hash['employee_id'])
        emp_id = task_hash.delete('employee_id')
        new_task = ts.create!(task_hash)
        assign_task(emp_id, new_task.id)
      else
        ts.create!(task_hash)
      end
    end
  end

  def manager
    @manager ||= user
  end

  def manager_id
    manager.id
  end

  def employee_reports(employee)
    users_reports.where(:user_id => employee.id)
  end

  def report_for_user(employee)
    employee_reports(employee).first_or_create
  end

  def assign_task(employee_id, task_id)
    report_for_user(get_employee(employee_id)).add_task(task_id)
  end

  def assign_part(employee_id, part_id)
    report_for_user(get_employee(employee_id)).add_part(part_id)
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

  def completed_parts(options = {})
    @used_parts = []
    get_reports(options).each { |u_r| @used_parts += u_r.parts.where(used: true) }
    @used_parts
  end

  def incomplete_tasks(options = {})
    @incomplete_tasks = []
    get_reports(options).each { |u_r| @incomplete_tasks += u_r.tasks.where(complete: false) }
    @incomplete_tasks
  end

  def completed_tasks(options = {})
    @completed_tasks = []
    get_reports(options).each do |u_r|
      @completed_tasks << u_r.reports_tasks.where(complete: true)
    end
    @completed_tasks
  end

  def tasks_completion_percent(options = {})
    (completed_tasks.length.to_f / assigned_tasks(options).length.to_f).round(2)
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