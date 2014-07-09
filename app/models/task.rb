class Task < ActiveRecord::Base
  include JsonSerializingModel

  belongs_to :user
  belongs_to :company
  belongs_to :project
  has_many :reports_tasks
  has_many :users_reports, :through => :reports_tasks

  attr_accessible :description, :manager 

  def manager 
    @manager ||= self.user 
  end 

end
