class ReportPart < ActiveRecord::Base
  include JsonSerializingModel
  has_one :part 
  belongs_to :user_reports
  has_many :photos
  has_and_belongs_to_many :locations

  attr_accessible :complete, :note, :completion_time, :manager

  def self.manager 
    @manager ||= user_report.manager 
  end 
end 