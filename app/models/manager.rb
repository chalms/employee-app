class Manager < User
  include JsonSerializingModel
  attr_accessible :hours, :days_worked, :assigned_tasks,:completed_tasks, :assigned_parts, :completed_parts, :tasks_completion_percent, :parts_completion_percent, :reports_completion_percent, :todays_activity, :email, :name, :employee_number
  has_many :user_chats
  has_many :chats, :through => :user_chats
  has_many :user_messages
  has_many :messages, :through => :user_messages
  has_many :reports
  has_many :users_reports, :through => :reports
  has_many :users, :through => :user_reports
  has_many :report_tasks, :through => :users_reports
  has_many :report_parts, :through => :users_reports
  has_many :projects, :through => :reports

  def update(params)
  	params = clean_params(params)
  	update!
  end

  def hours(options = {})
    @hours = 0
    get_users_report(options).each { |u_r| @hours += u_r.hours }
    @hours
  end

  def days_worked(options = {})
    @days_worked = 0
    h = {}
    get_users_report(options).each { |u_r| h[u_r.date] = true }
    h.each { |k, v| @days_worked += 1 }
    @days_worked
  end

  def self_destruct
  	self.user_chats.destroy_all
  	self.user_messages.destroy_all
  	self.reports.each do |r|
  		r.update_attributes!({:user_id => company.admin.id})
  	end
  	self.user_reports.each do |r|
			r.update_attributes!({
				:user_id => company.admin.id
			})
		end
		self.projects_users.each do |p_u|
			p_u.update_attributes!({
				:user_id => company.admin.id
			})
		end
		self.contact.destroy
		Company.find(company.id).users.find(self.id).destroy
	end

  private

  def update!
  	raise Exceptions::StdError, "Could not update attributes!" unless (self.update_attributes!(params))
  end

  def clean_params(params)
  	(params[:manager] || params)
  end
end
