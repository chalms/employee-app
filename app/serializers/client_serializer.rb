class ClientSerializer < ActiveModel::Serializer
  attributes :name, :manager, :complete, :assigned_parts, :assigned_tasks, :complete_parts, :complete_tasks, :company, :complete?, :hours, :days_worked
  belongs_to :company
  has_many :locations 
  has_many :projects
  has_many :reports, :through => { :projects }
  has_many :tasks
  has_many :parts 
  has_one :manager 
  has_many :contacts 
end
