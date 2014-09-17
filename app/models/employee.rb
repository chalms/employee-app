class Employee < User

  def get_name
    if (self.name.blank?)
      self.email
    else
      self.name
    end
  end

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