class Worker < User 
	def is_manager? 
		return false 
	end 

	def is_admin? 
		return false 
	end 

	def is_worker? 
		return true 
	end 
end 