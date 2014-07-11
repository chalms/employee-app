class Admin < User
  def is_manager?
    return false
  end

  def is_admin?
    return true
  end

  def is_employee?
    return false
  end
end