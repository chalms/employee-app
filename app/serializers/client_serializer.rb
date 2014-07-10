class ClientSerializer < ActiveModel::Serializer
  attributes :name, :manager, :complete, :assigned_parts, :assigned_tasks, :completed_parts, :completed_tasks, :company, :complete?, :hours, :employee_days_worked, :company_id, :user_id
  has_many :locations
  has_many :projects
  has_many :reports, :through => :projects
  has_many :tasks
  has_many :parts
  has_many :contacts
end
