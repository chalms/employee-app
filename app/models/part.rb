class Part < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :company
  belongs_to :user
  belongs_to :project
  
  has_many :reports_parts
  has_many :users_reports, :through => :reports_parts
  attr_accessible :barcode, :name, :manager 

  def manager 
    @manager ||= self.user 
  end 

end 