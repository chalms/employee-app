class ReportSerializer < ApplicationSerializer
  attrributes :summary, :date, :complete, :assigned_parts,
    :assigned_tasks, :unused_parts, :complete_parts, :incomplete_tasks,
    :complete_tasks, :company, :complete?, :hours, :days_worked

  belongs_to :user, :as => :manager 
  has_many :users, :as => :employees

  has_many :users_reports

  has_and_belongs_to_many :tasks
  has_and_belongs_to_many :parts
end
