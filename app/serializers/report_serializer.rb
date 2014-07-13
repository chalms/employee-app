class ReportSerializer < ApplicationSerializer
  attributes :summary, :date, :complete, :assigned_parts, :assigned_tasks, :unused_parts, :completed_parts, :incomplete_tasks, :completed_tasks, :company, :complete?, :hours, :employee_days_worked, :manager, :manager_id, :user_id

  has_many :users_reports
  has_many :users, :through => :users_reports
  has_many :locations_reports
  has_many :report_tasks, :through => :users_reports
  has_many :report_parts, :through => :users_reports
  has_many :tasks, :through => :reports_tasks
  has_many :parts, :through => :reports_tasks
end
