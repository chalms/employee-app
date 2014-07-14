class Photo < ActiveRecord::Base
  include JsonSerializingModel
  attr_accessible :data, :owner
  belongs_to :message
  belongs_to :reports_part
  belongs_to :reports_task
  validate :has_one_owner?

  def has_one_owner?
    raise Exceptions::StdError, "Photo cannot have multiple owners" unless (reports_part ^ reports_task ^ message)
  end

  def owner=(o)
    if (o)
      @owner = o
    end
  end

  def owner
    has_one_owner?
    @owner ||= if (self.message)
      @owner = message
    elsif (self.reports_part)
      @owner = reports_part
    elsif (self.reports_task)
      @owner = reports_task
    end
  end
end