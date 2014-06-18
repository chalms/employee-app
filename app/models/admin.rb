class Admin < User
	def is_manager? 
		return false
	end 

	def is_admin? 
		return true
	end 

	def is_worker? 
		return false 
	end 
end
