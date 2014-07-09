class CompanyAdminController < ApplicationController
  def authentication 
    puts params
    user = User.find_by_email(params[:email])
    puts "user: #{user}"
    token = current_api_session_token
    token.user = user 
    @token = token.token
    @user = user
    validate_user!
    @user = UserSerializer.new(user).to_json
    count = EmployeeLog.where(company: user.company).count
    puts "count: #{count}"
    if (EmployeeLog.where(company: user.company).count > 1)
      render :admin_home 
    else 
      render :admin_onboarding
    end 
rescue Exceptions::StdError => e
    puts "error message #{e}"
    flash[:error] = e
    if (@token) 
      render :action => :admin_home 
    else 
      render :action => :admin_onboarding
    end 
  end 

  def admin_onboarding
    @user = current_user
    validate_user!
  end

  def admin_home 
    @user = current_user
    validate_user!
  end 

  def import
    @user.company.import_employee_logs(params[:file])
  end


  private 
  def validate_user! 
    raise Exceptions::StdError, "Token is not valid!" unless (@token)
    raise Exceptions::StdError, "Password is not valid!" unless(_provided_valid_password?)
    raise Exceptions::StdError, "User is not a company admin" unless (@user.role == 'companyAdmin')
  end

  def _provided_valid_password?
    params[:password] && UserAuthenticationService.authenticate_with_password!(@user, params[:password])
  end

  def _provided_valid_api_session_token?
    params[:api_key] && UserAuthenticationService.authenticate_with_api_key!(@user, params[:api_key], current_api_session_token.token)
  end

  def api_session_token_url(token)
    api_sessions_path(token)
  end
end 