class Task < ActiveRecord::Base
  include JsonSerializingModel

  belongs_to :user, as: :manager 
  belongs_to :company
  belongs_to :project
  has_many :report_tasks
  has_many :user_reports, :through => :report_tasks

  attr_accessible :description

end
