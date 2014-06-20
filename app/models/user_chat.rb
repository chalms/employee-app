class UserChat < ActiveRecord::Base
	has_one :user 
	has_one :chat 
end 