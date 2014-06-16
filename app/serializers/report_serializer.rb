class ReportSerializer < ApplicationSerializer
  attributes :id, :report_date, :checkin, :checkout, :description
  has_one  :worker,
  has_one  :manager,
  has_many :tasks, 
  has_many :equipment,
  has_many :coordinates
end
