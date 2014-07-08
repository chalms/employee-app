class ReportPartSerializer < ActiveModel::Serializer
  has_one :part 
  belongs_to :user_report 
  has_many :photos
  has_one :location, as: :owner 
  attributes :complete, :note, :completion_time, :manager
end
