module AppHelper
  def error!(e, origin)
    origin ||= :sign_up
    flash[:error] = e
    render :action => origin
  end

  def route!
    if (@user.role == 'companyAdmin')
      return admin!
    elsif (@user.role == 'manager')
      return manager!
    else
      return employee!
    end
  end

  def admin!
    @load = true
    @load = false if (@user.company.employee_logs.count > 1)
    @user = UserSerializer.new(@user)
    @route = 'admins/' + @user.id
  end

  def manager!
    @user = UserSerializer.new(@user)
    @route = 'managers/' + @user.id
  end

  def employee!
    @user = UserSerializer.new(@user).to_json
    @route = 'users/' + @user.id
  end

end