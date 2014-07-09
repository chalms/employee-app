class Part < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :company
  belongs_to :user, as: :manager
  belongs_to :project
  
  has_many :report_parts
  has_many :user_reports, :through => :report_parts
  attr_accessible :barcode, :name


end 