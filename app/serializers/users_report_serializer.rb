class UsersReportSerializer < ActiveModel::Serializer

  attributes :complete, :checkin, :checkout, :parts, :tasks, :location, :date, :hours, :employee, :manager, :report, :user, :report_id, :user_id
  has_many :reports_parts
  has_many :reports_tasks
  has_and_belongs_to_many :locations
end