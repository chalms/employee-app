class ProjectSerializer < ActiveModel::Serializer
  attributes :name, :start_date, :end_date, :budget, :complete, :assigned_parts, :assigned_tasks, :completed_parts, :completed_tasks, :company_id, :complete?, :hours, :employee_days_worked, :employees, :managers, :manager_number
  has_many :reports
  has_many :parts
  has_many :tasks
  has_many :contacts, :through => :users
  has_many :clients

end
