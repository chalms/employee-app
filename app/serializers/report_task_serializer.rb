class ReportTaskSerializer < ActiveModel::Serializer
  belongs_to :task 
  belongs_to :user_report
  has_many :photos 
  has_one :location, as: :owner
  has_many :parts 

  attributes :complete, :note, :completion_time, :manager
end
