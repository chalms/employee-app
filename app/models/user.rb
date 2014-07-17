class User < ActiveRecord::Base
  include JsonSerializingModel
  attr_accessible :email, :name, :employee_number, :hours, :days_worked, :role, :password, :company_id, :assigned_tasks, :completed_tasks, :assigned_parts, :completed_parts, :tasks_completion_percent, :reports_completion_percent
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
  has_many :projects, :through => :reports
  has_many :users_messages
  has_many :messages, :through => :users_messages

  def update(params)
    params = (params[type.to_sym] || params)
  end

  def company
    @company ||= Company.find(company_id)
  end

  def add_report(params)
    params = params[:report] || params
    hash = {}
    hash[:date] = string_to_date(params)
    hash[:summary] = params[:summary] || nil
    hash[:project_id] = params[:project_id] || nil
    hash[:client_id] = params[:client_id] || nil
    report = reports.create!(hash)
    report.add_tasks(params[:tasks]) if params[:tasks]
    return report
  end

  def messages(id)
    @users_messages = users_chats.find(id.to_i).users_messages.find(:all, :order => "date desc", :limit => 20)
    @messages = []
    @users_messages.andand.each do |m|
      message = m.message
      m.update_attribute(:read, true) unless m.read
      if (m.user == message.sender)
        if (message.read_by_all)
          status = "#{message.updated_at}"
        else
          status = "#{message.updated_at} - #{message.read_by} of #{message.users_messages.count} read"
        end
      else
        status = "#{message.sender.name} sent at #{m.created_at}"
      end
       @messages << {:text => message.data, :status => status }
    end
    return @messages
  end

  def string_to_date(params)
    if params[:date].is_a? String
      date = Date.strptime(params[:date], '%m/%d/%Y')
      return date
    else
      return nil
    end
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
    return (self.role.downcase == 'companyadmin' || self.role.downcase == 'admin')
  end

  def is_manager?
    self.update_attribute(:type, 'Manager') if (self.role == 'manager' && self.type == nil)
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
    emp = company.employee_logs.find_by_employee_number(self.employee_number)
    raise Exceptions::StdError, "Not a valid employee id for that company!" unless (emp.andand.present?)
    self.update_attributes({role: emp.role})
    @role = self.role
  end

  def hours(options = {})
    @hours = 0
    return @hours unless (self.role == 'employee')
    get_users_reports(options).each { |u_r| @hours += u_r.hours }
    @hours
  end

  def days_worked(options = {})
    @days_worked = 0
    h = {}
    return @days_worked unless (self.role.downcase == 'employee')
    get_users_reports(options).each { |u_r| h[u_r.date] = true }
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

  def assigned_reports(options = {})
    get_users_reports(options)
  end

  def completed_reports(options = {})
    assigned_reports(options).where(complete: true)
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
    @todays_activity = get_users_reports({"today" => true})
  end

  private

  def get_users_reports(options = {})
    if (options["before"])
      @users_reports = users_reports.where('date < ?', Date.today)
    elsif (options["today"])
     @users_reports = users_reports.where('date = ?', Date.today)
    elsif (options["future"])
      @users_reports =users_reports.where('date > ?', Date.today)
    else
      if (options.count != 0)
        if (options[:project_id])
          @users_reports = users_reports.joins(:report).where(reports: { project_id: options.delete(:project_id) })
        else
          @users_reports = users_reports.where(options)
        end
      else
        @users_reports = users_reports
      end
    end
    @users_reports
  end

  def _set_defaults
    self.api_secret ||= MicroToken.generate(128)
  end
end
