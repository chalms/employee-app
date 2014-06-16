class Worker < ActiveRecord::Base
	has_one :user 
	has_many :managers
end
