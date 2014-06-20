class ReportSerializer < ApplicationSerializer
  attributes :id, :report_date, :checkin, :checkout, :description
end
