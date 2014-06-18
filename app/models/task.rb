class Task < ActiveRecord::Base
	belongs_to :report
	has_many :parts
	has_one :completed_location
end
