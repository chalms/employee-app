class ReportsTask < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :task
  belongs_to :users_report
  has_many :photos
  has_and_belongs_to_many :locations
  attr_accessible :complete, :note, :completion_time, :manager_id, :report_id, :task_id

  def manager
    puts "manager"
    @manager ||= users_report.manager
  end

  def manager_id

    puts "manager_id"
    manager.id
  end

  def users_report
    puts "users_report"
    @users_report ||= self.users_report
    @users_report ||= UsersReport.find(self.users_report_id)
    @users_report
  end

  def report_id
    puts "report_id"
    @report_id ||= report.id
  end

  def report
    puts "report"
    @report ||= (users_report.report || Report.find(users_report.report_id))
  end
end