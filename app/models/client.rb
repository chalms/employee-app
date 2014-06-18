class Client < ActiveRecord::Base 
	has_many :reports 
	has_many :client_locations
end 