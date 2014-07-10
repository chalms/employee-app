class Part < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :company
  belongs_to :user
  belongs_to :project
  belongs_to :report
  has_many :reports_parts
  has_many :users_reports, :through => :reports_parts
  attr_accessible :barcode, :name, :manager, :assignment

  def manager
    @manager ||= self.user
  end

  def assignment
    unless (@assignment)
      if (reports_parts.count > 0)
        @assignment = true
        update_attributes!({:assigned => :true})
      else
        @assignment = false
      end
    end
    @assignment
  end

end