class ManagerSerializer < UserSerializer
  attributes :employee_number

  has_many :chats
  has_many :users_messages
  has_many :messages, :through => :users_messages
  has_many :reports
  has_many :users_reports, :through => :reports
  has_many :users, :through => :users_reports
  has_many :report_tasks, :through => :users_reports
  has_many :report_parts, :through => :users_reports
  has_many :projects_users
  has_many :projects, :through => :projects_users
end