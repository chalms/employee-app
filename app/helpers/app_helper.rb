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
    @route = "/admins/#{@user.id}"
    puts @route
    @route
  end

  def manager!
    @route = 'managers/' + @user.id.to_s
    puts @route
    @route
  end

  def employee!
    @user.api_session_token = @tok
    @route = @user.to_json
    puts @route
    @route
  end

end