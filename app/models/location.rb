class Location < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :client
  has_and_belongs_to_many :reports_parts
  has_and_belongs_to_many :reports_tasks
  has_and_belongs_to_many :users_reports
  has_and_belongs_to_many :reports
  validate :validator
  attr_accessible :owner, :address, :city, :country, :type, :name

  def validator
    if (company || user || task || part || reports_part || reports_task || users_report || client)
      return true
    else
      raise Exceptions::StdError, "Location has no owner"
      return false
    end
  end

  def owner
    @owner ||= (company || user || task || part || reports_part || reports_task || users_report || client)
  end
end
