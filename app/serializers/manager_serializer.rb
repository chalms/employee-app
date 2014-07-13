class ManagerSerializer < ActiveModel::Serializer
  attributes :hours, :days_worked, :assigned_tasks,
  :completed_tasks, :assigned_parts,
  :completed_parts, :tasks_completion_percent,
  :parts_completion_percent, :reports_completion_percent, :todays_activity, :email, :name, :employee_number

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