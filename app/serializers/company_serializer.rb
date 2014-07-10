class CompanySerializer < ActiveModel::Serializer
  attributes :name, :admin, :reports, :complete, :assigned_parts, :assigned_tasks, :completed_parts, :completed_tasks, :complete?, :hours, :employee_days_worked, :managers, :employees

  has_many :users
  has_one :contact
  has_many :projects
  has_many :parts
  has_many :tasks
  has_many :clients

end
