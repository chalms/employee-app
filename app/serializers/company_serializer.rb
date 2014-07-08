class CompanySerializer < ActiveModel::Serializer
  attributes :name, :admin, :reports, :complete, :assigned_parts, :assigned_tasks, :complete_parts, :complete_tasks, :company, :complete?, :hours, :days_worked

  has_many :users, :as => :managers 
  has_many :users, :as => :employees 
  has_one :contact 
  has_many :projects 
  has_many :parts 
  has_many :tasks 
  has_many :clients

end
