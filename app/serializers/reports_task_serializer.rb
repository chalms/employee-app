class ReportsTaskSerializer < ActiveModel::Serializer
  has_one :part
  has_many :photos
  has_many :locations_reports_parts
  has_many :locations, :through => :locations_reports_parts

  attributes :complete, :note, :completion_time, :manager_id, :users_report_id, :report_id, :task_id
end
