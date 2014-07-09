class LoginController < ApplicationController
  def signup 
    flash[:notice] = ""
  end 

  def login
    flash[:notice] = ""
  end 

  def signout 
    current_api_session_token.delete!
    render :sign_up
  end 

  def valid_login
    puts params
    origin = :login
    user = User.find_by_email(params[:email])
    validate_password!
    set_token!(user)
    validate_user!(user)
rescue Exceptions::StdError => e
    error!(e, origin)
rescue UserAuthenticationService::NotAuthorized => e
    error!(e, origin)
  end 

  def valid_signup 
    puts params
    origin = :signup
    validate_params!(params)
    company = validate_company!(params)
    employee_logs = validate_employee_logs!(company, params)
    user = create_user!(company, employee_logs, params)
    set_token!(user)
    validate_user!(user)
rescue Exceptions::StdError => e
    error!(e, origin)
rescue UserAuthenticationService::NotAuthorized => e
    error!(e, origin)
  end 

private 

  def error!(e, origin)
    puts "error message #{e}"
    origin ||= :sign_up
    flash[:error] = e
    render :action => origin
  end

  def admin(user)
    count = EmployeeLog.where(company: user.company).count
    if (EmployeeLog.where(company: user.company).count > 1)
      @load = false 
    else
      @load = true 
    end 
    render :admin
  end 

  def validate_params!(params)
    raise Exceptions::StdError, "A valid email is required!" unless (params[:email])
    raise Exceptions::StdError, "An employee number is required!" unless (params[:employee_number])
    raise Exceptions::StdError, "Please select a company!" unless (params[:company_id])
  end 

  def set_token!(user)
    token = current_api_session_token
    token.user = user
    @token = token.token
    raise Exceptions::StdError, "Authorization is not accepted!" unless (@token)
  end

  def validate_password!
    raise Exceptions::StdError, "Password is not valid!" unless(_provided_valid_password?)
  end 

  def validate_employee_logs!(company, params)
    employee_logs = company.employee_logs.where(:employee_number => params[:employee_number])
    raise Exceptions::StdError, "Employee that was given does not match any existing records!" unless employee_logs
    return employee_logs
  end 

  def validate_company!(params)
    company = Company.find_by_id(params[:company_id])
    raise Exceptions::StdError, "Company does not exist" unless company
    return company
  end 

  def validate_create_user! 
    raise Exceptions::StdError, "Token is not valid!" unless (@token)
    raise Exceptions::StdError, "Sorry there must be an error on our end... We are fixing it as quick as possible" unless(@user)
  end

  def create_user!(company, employee_logs, params)
    return User.create!({  
      :email => params[:email], 
      :name => params[:name], 
      :company_number => company.id,
      :password => params[:password], 
      :role => employee_logs.role
    })
  end 

  def validate_user!(user)
    @user = UserSerializer.new(user).to_json
    if (@user.role == 'companyAdmin')
      admin!(user)
    elsif (@user.role == 'manager')
      render :home
    end 
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