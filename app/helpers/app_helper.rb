module AppHelper
  def error!(e, origin)
    origin ||= :signup
    flash[:error] = e
    render :controller => origin, :action => :new
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
    @route = 'admins/show'
  end

  def manager!
    @route = 'managers/' + @user.id.to_s
  end

  def employee!
    @user.api_session_token = @tok
    @route = @user.to_json
  end

end