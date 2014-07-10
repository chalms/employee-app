class Task < ActiveRecord::Base
  include JsonSerializingModel

  belongs_to :user
  belongs_to :company
  belongs_to :project
  belongs_to :report
  has_many :reports_tasks
  has_many :users_reports, :through => :reports_tasks

  attr_accessible :description, :manager, :assignment

  def manager
    @manager ||= self.user
  end

  def assignment
    unless (@assignment)
      if (reports_tasks.count > 0)
        @assignment = true
        update_attributes!({:assigned => :true})
      else
        @assignment = false
      end
    end
    @assignment
  end

end
