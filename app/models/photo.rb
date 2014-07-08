class Photo < ActiveRecord::Base 
  include JsonSerializingModel
  attr_accessible :data, :owner 

  belongs_to :report_part 
  belongs_to :report_task 
  belongs_to :message 

  validate :has_one_owner?

  def has_one_owner? 
    raise Exceptions::StdError, "Photo cannot have multiple owners" unless (report_part ^ report_task ^ message)
  end 

  def owner=(o)
    if (o)
      @owner = o 
    end 
  end

  def owner
    has_one_owner?
    @owner ||= do 
      if (self.message)
        @owner = message
      elsif (self.report_part)
        @owner = report_part 
      elsif (self.report_task)
        @owner = report_task
      end 
    end 
  end 
end 