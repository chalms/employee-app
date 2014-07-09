class ReportsTaskSerializer < ActiveModel::Serializer
  belongs_to :task 
  belongs_to :users_report
  has_many :photos 
  has_one :location, as: :owner
  has_many :parts 

  attributes :complete, :note, :completion_time, :manager
end
