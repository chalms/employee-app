class Chat < ActiveRecord::Base
	has_many :messages
	
	def to_json 
		return self.messages.to_json + self.to_json
	end 
end
