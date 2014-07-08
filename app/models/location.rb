class Location < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :task
  belongs_to :report 
  belongs_to :part
  belongs_to :client 

  validate :validator
  attr_accessible :owner 

  def validator
    if (company || user || task || part)
      return true 
    else 
      raise Exceptions::StdError, "Location has no owner"
      return false 
    end  
  end 

  def owner=(own)
    if ((own.is_a? Company) || (own.is_a? User))
      @owner = own
    end 
  end 

  def owner 
    @owner ||= (company || user)
  end
end 
