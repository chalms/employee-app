class ProjectSerializer < ActiveModel::Serializer
  attributes :name, :start_date, :end_date, :budget, :complete, :assigned_parts, :assigned_tasks, :completed_parts, :completed_tasks, :company_id, :complete?, :hours, :employee_days_worked, :employees, :managers, :manager_number, :manager

  has_many :reports
  has_many :users_reports, :through => :reports
  has_many :users, :through => :users_reports
  has_many :contacts, :through => :users
  has_many :report_tasks, :through => :user_reports
  has_many :report_parts, :through => :user_reports
  has_many :tasks, :through => :report_tasks
  has_many :parts, :through => :report_parts
  has_many :clients_projects
  has_many :clients, :through => :clients_projects
end
