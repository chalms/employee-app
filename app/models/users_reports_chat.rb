class UsersReportsChat < Chat
  belongs_to :users_report
  attr_accessible :users_report_id
end
