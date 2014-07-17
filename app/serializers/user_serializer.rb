class UserSerializer < ActiveModel::Serializer
  attributes :email, :name, :password, :employee_number, :hours, :days_worked, :id, :company_id, :company, :assigned_reports, :completed_reports

  has_one :contact
  has_many :users_reports
  has_many :users_chats
  has_many :chats, :through => :users_chats
  has_many :reports, :through => :users_reports
  has_many :projects, :through => :reports
  has_many :users_messages
  has_many :messages, :through => :users_messages

  def assigned_reports(options = {})
    @assigned_reports = []
    get_users_reports(options)
  end

  def completed_reports(options = {})
    assigned_reports(options).where(completed: true)
  end


  def get_users_reports(options = {})
    if (options["before"])
      users_reports.where('date < ?', Date.today)
    elsif (options["today"])
      users_reports.where('date = ?', Date.today)
    elsif (options["future"])
      users_reports.where('date > ?', Date.today)
    else
      users_reports(options)
    end
  end


end