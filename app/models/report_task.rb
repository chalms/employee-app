class ReportTask < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :task 
  belongs_to :user_report
  has_many :photos 
  has_one :location, as: :owner
  
  attr_accessible :complete, :note, :completion_time, :manager

  def self.manager 
    @manager ||= user_report.manager 
  end
end 