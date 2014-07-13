class Task < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :user
  belongs_to :company
  belongs_to :project
  belongs_to :report
  has_many :reports_tasks
  has_many :users_reports, :through => :reports_tasks
  has_many :reports, :through => :users_reports
  has_many :projects, :through => :reports

  attr_accessible :description, :name, :manager, :manager_id, :assignment, :owners

  def owners
    unless (@owners)
      h = {}
      h['company'] = self.company_id
      h['user'] = self.user_id if (self.user_id)
      h['project'] = self.project_id if (self.project_id)
      h['report'] = self.report_id if (self.report_id)
      @owners = h
    end
    @owners
  end

  def manager
    @manager ||= self.user
    @manager
  end

  def manager_id
    return manager.id if (!!manager)
    manager
  end

  def assignment
    unless (@assignment)
      if ((reports_tasks.count > 0) || self.assigned)
        @assignment = true
        self.update_attribute(:assigned, true)
      else
        @assignment = false
      end
    end
    @assignment
  end

end
