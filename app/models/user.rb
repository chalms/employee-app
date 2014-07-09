class User < ActiveRecord::Base
  include JsonSerializingModel
  attr_accessible :email, :name, :password_digest, :employee_number, :hours, :days_worked, :id, :role_ids 
  after_initialize :_set_defaults, :valid_employee_id?
  validates_presence_of :password, :length => {:minimum  => 6},  on: :create!
  validate :email, :format => {:with => /\A[^@]+@[^@]+\.[^@]+\Z/}
  before_save :setup_role
  validate :valid_employee_id?
  has_one :contact 
  has_many :user_reports
  belongs_to :company 
  has_and_belongs_to_many :chats
  has_and_belongs_to_many :roles 
  has_and_belongs_to_many :messages
  

  def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
  end

  # Default role is "Registered"
  def setup_role 
    if self.role_ids.empty?     
      self.role_ids = [2] 
    end
  end

  def clients 
    return nil
  end 

  def chats 
    return self.user_chats.map{ |ur| ur.chat }
  end 

  def reports 
    return self.user_reports.map{ |ur| ur.report }
  end 

  def role(r)
    if (r.blank?)
      @role = 'user'
    end 
  end 

  def is_admin? 
    return (@role == 'admin') 
  end 

  def is_manager? 
    return (@role == 'manager')
  end 

  def password=(password)
    write_attribute(:password, BCrypt::Password.create(password))
  end

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

  private

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

  def _set_defaults
    self.api_secret ||= MicroToken.generate(128)
  end
end
