class Part < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :company
  belongs_to :user, as: :manager
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :reports
  has_and_belongs_to_many :user_reports 

  attr_accessible :barcode, :name
end 