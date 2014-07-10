class LocationsReports < ActiveRecord::Base
  belongs_to :location
  belongs_to :report
end