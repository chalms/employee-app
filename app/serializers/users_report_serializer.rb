class UsersReportSerializer < ActiveModel::Serializer

  attributes :complete, :checkin, :checkout, :parts, :tasks, :date, :hours, :employee, :manager, :report, :user, :report_id, :user_id
  has_many :reports_tasks


end