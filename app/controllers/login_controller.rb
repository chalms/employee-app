class LoginController < ApplicationController
  def sign_up
    @companies = []
    Company.all.each { |c| @companies << c.name }
  # puts @companies
    @companies
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
  # puts params
    origin = :login
    @user = User.find_by_email(params[:email])
    validate_password!
    set_token!
    validate_user!
rescue Exceptions::StdError => e
  # puts "Exception called! #{e}"
    error!(e, origin)
rescue UserAuthenticationService::NotAuthorized => e
  # puts "Exception called! #{e}"
    error!(e, origin)
  end

  def valid_signup
  # puts params
    origin = :sign_up
    validate_params!(params)
    company = validate_company!(params)
    employee_log = validate_employee_logs!(company, params)
    create_user!(company, employee_log, params)
    set_token!
    validate_user!
rescue Exceptions::StdError => e
 # puts "Exception called! #{e}"
    error!(e, origin)
rescue UserAuthenticationService::NotAuthorized => e
 # puts "Exception called! #{e}"
    error!(e, origin)
  end

private

  def error!(e, origin)
  # puts "Error message was found with: #{e}"
  # puts "Origin is equal to: #{origin.to_s}"
    origin ||= :sign_up
    flash[:error] = e
    render :action => origin
  end

  def admin!
  # puts "setting load parameter"
    if (@user.company.employee_logs.count > 1)
      @load = false
    else
      @load = true
    end
  # puts "@user = UserSerializer.new "
    @user = UserSerializer.new(@user)
  # puts "render :admin"
    render 'home/admin'
  end

  def validate_params!(params)
    raise Exceptions::StdError, "A valid email is required!" unless (params[:email])
    raise Exceptions::StdError, "An employee number is required!" unless (params[:employee_number])
    raise Exceptions::StdError, "Please select a company!" unless (params[:company_id])
  end

  def set_token!
    token = current_api_session_token
  # puts "Current api session token complete"
    token.user = @user
  # puts "Token.user -> @user"
    @token = token.token
  # puts "@token is set to token.token"
  # puts @token.inspect
    raise Exceptions::StdError, "Authorization is not accepted!" unless (@token)
  end

  def validate_password!
    raise Exceptions::StdError, "Password is not valid!" unless(_provided_valid_password?)
  end

  def validate_employee_logs!(company, params)
    employee_log = company.employee_logs.where(:employee_number => params[:employee_number]).andand.first

    raise Exceptions::StdError, "Employee that was given does not match any existing records!" unless employee_log
    return employee_log
  end

  def validate_company!(params)
    company = Company.find_by_id(params[:company_id].to_i)
    raise Exceptions::StdError, "Company does not exist" unless company
    return company
  end

  def validate_create_user!
    raise Exceptions::StdError, "Token is not valid!" unless (@token)
    raise Exceptions::StdError, "Sorry there must be an error on our end... We are fixing it as quick as possible" unless(@user)
  end

  def create_user!(company, employee_log, params)
    @user = company.users.create!({
      :email => params[:email],
      :name => params[:name],
      :employee_number => params[:employee_number],
      :password => params[:password],
      :role => employee_log.role
    })
  # puts "user created!"
    @user
  end

  def validate_user!
  # puts "user being validated!"
    if (@user.role == 'companyAdmin')
    # puts "calling admin!"
      admin!
    elsif (@user.role == 'manager')
      @user = UserSerializer.new(@user).to_json
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