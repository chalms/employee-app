class Manager < User
  include JsonSerializingModel
  attr_accessible :employee_number

  has_many :users_chats
  has_many :chats, :through => :users_chats
  has_many :user_messages
  has_many :messages, :through => :users_messages
  has_many :reports
  has_many :users_reports, :through => :reports
  has_many :users, :through => :users_reports
  has_many :report_tasks, :through => :users_reports
  has_many :report_parts, :through => :users_reports
  has_many :projects, :through => :reports

  def update(params)
  	params = clean_params(params)
  	update!
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
