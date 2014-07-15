class ReportsChat < Chat
  belongs_to :report
  attr_accessible :report_id
end