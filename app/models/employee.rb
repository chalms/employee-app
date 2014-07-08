class Employee < User
  def is_manager? 
    return false
  end 

  def is_admin? 
    return false 
  end 

  def is_employee? 
    return true
  end 
end