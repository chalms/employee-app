class ProjectSerializer < ActiveModel::Serializer
  attributes :name, :start_date, :end_date, :budget, :complete, :assigned_parts, :assigned_tasks, :completed_parts, :completed_tasks, :company_id, :complete?, :hours, :days_worked, :employees, :managers, :manager_number, :manager

  has_many :reports
  has_many :users_reports, :through => :reports
  has_many :users, :through => :users_reports
  has_many :contacts, :through => :users
  has_many :reports_tasks, :through => :users_reports
  has_many :reports_parts, :through => :users_reports
  has_many :tasks, :through => :reports_tasks
  has_many :parts, :through => :reporst_parts
  has_many :clients_projects
  has_many :clients, :through => :clients_projects
end
