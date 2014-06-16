class Manager < ActiveRecord::Base
	has_one :user 
	has_many :workers
end
