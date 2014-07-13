class User < ActiveRecord::Base
  include JsonSerializingModel
  attr_accessible :email, :name, :employee_number, :hours, :days_worked, :role, :password, :company_id
  after_initialize :_set_defaults
  validates_presence_of :password, :length => {:minimum  => 6},  on: :create!
  validate :email, :format => {:with => /\A[^@]+@[^@]+\.[^@]+\Z/}
  validates :employee_number, :uniqueness => true
  after_create :valid_employee_id?, :set_type
  has_one :contact
  has_many :users_reports
  belongs_to :company
  has_many :users_chats
  has_many :chats, :through => :users_chats
  has_many :reports
  has_many :users_messages
  has_many :messages, :through => :users_messages

  def update(params)
    params = (params[type.to_sym] || params)
  end

  def company
    @company ||= Company.find(company_id)
  end

  def set_type
    puts "set_type"
    if (role == 'companyAdmin')
      @type = 'Admin'
    elsif (role == 'manager')
      @type = 'Manager'
    else
      @type = 'Employee'
    end
    self.update_attribute(:type, @type) if (@type)
  end

  def role?(r)
    (self.type == r)
  end

  def clients
    return nil
  end

  def is_admin?
    return (self.role == 'companyAdmin')
  end

  def is_manager?
    self.update_attribute(:type, 'manager') if (self.role == 'manager' && self.type == nil)
  end

  def password=(password)
    write_attribute(:password, BCrypt::Password.create(password))
  end

  def company=(comp)
    @company = Company.find(id: comp)
    raise Exceptions::StdError, "Invalid Company!" unless @company.andand.present?
    @company
  end

  def valid_employee_id?
    puts "valid_employee_id"
    puts "#{self.employee_number}"
    puts "#{company.employee_logs.inspect}"
    emp = company.employee_logs.find_by_employee_number(self.employee_number)
    puts "EMPLOYEE LOGS: #{emp.inspect}"
    raise Exceptions::StdError, "Not a valid employee id for that company!" unless (emp.andand.present?)
    self.update_attributes({role: emp.role})
    puts "#{self.role}"
    @role = self.role
  end

  def hours(options = {})
    @hours = 0
    return @hours unless (self.role == 'employee')
    get_users_report(options).each { |u_r| @hours += u_r.hours }
    @hours
  end

  def days_worked(options = {})
    @days_worked = 0
    h = {}
    return @days_worked unless (self.role == 'employee')
    get_users_report(options).each { |u_r| h[u_r.date] = true }
    h.each { |k, v| @days_worked += 1 }
    @days_worked
  end

  def assigned_tasks(options = {})
    @assigned_tasks = []
    get_users_reports(options).each {|u_r| @assigned_tasks += u_r.assigned_tasks}
    @assigned_tasks
  end

  def completed_tasks(options = {})
    @completed_tasks = []
    get_users_reports(options).each {|u_r| @completed_tasks += u_r.completed_tasks}
    @completed_tasks
  end

  def assigned_parts(options = {})
    @assigned_parts = []
    get_users_reports(options).each {|u_r| @assigned_parts += u_r.assigned_parts}
    @assigned_parts
  end

  def completed_parts(options = {})
    @completed_parts = []
    get_users_reports(options).each {|u_r| @completed_parts += u_r.completed_parts}
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

  def todays_activity
    @todays_activity = get_user_reports({"today" => true})
  end

  private

  def get_users_reports(options = {})
    if (options["before"])
      users_reports.where('date < ?', Date.today)
    elsif (options["today"])
      users_reports.where('date = ?', Date.today)
    elsif (options["future"])
      users_reports.where('date > ?', Date.today)
    else
      users_reports
    end
  end

  def _set_defaults
    self.api_secret ||= MicroToken.generate(128)
  end
end
