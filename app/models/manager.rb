class Manager < User

  
	def is_manager? 
		return true 
	end 

	def is_admin? 
		return false 
	end 

	def is_worker? 
		return false 
	end 
end
