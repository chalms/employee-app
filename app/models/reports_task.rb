class ReportsTask < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :task 
  belongs_to :users_report
  has_many :photos 
  has_and_belongs_to_many :locations
  
  attr_accessible :complete, :note, :completion_time, :manager

  def self.manager 
    @manager ||= users_report.manager 
  end
end 