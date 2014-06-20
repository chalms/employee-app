class UserReport < ActiveRecord::Base
	has_one :user 
	has_one :report 
end 