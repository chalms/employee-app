class ProjectSerializer < ActiveModel::Serializer
  attributes :name, :start_date, :end_date, :budget, :complete, :assigned_parts, :assigned_tasks, :complete_parts, :complete_tasks, :company, :complete?, :hours, :days_worked
  belongs_to :company 
  has_many :reports
  has_many :parts
  has_many :locations, :through => { :reports, :tasks, :parts, :clients }
  has_many :tasks, 
  has_many :users, as: :employees 
  has_many :users, as: :managers
  has_many :contacts, :through => { :users }
  has_one :client 
end
