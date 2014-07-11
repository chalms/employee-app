class ManagerSerializer < ActiveModel::Serializer
  attributes :hours, :days_worked, :assigned_tasks,
  :completed_tasks, :assigned_parts,
  :completed_parts, :tasks_completion_percent,
  :parts_completion_percent, :reports_completion_percent, :todays_activity, :email, :name, :employee_number

  has_many :chats
  has_many :user_messages
  has_many :messages, :through => :user_messages
  has_many :reports
  has_many :users_reports
  has_many :users, :through => :user_reports
  has_many :report_tasks, :through => :users_reports
  has_many :report_parts, :through => :users_reports
  has_many :projects_users
  has_many :projects, :through => :projects_users
end