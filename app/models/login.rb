class Login
  attr_reader :email, :password

  def initialize
    @email = ""
    @password = ""
    @route = ""
  end

  def update(params)
    if (params[:login])
      params = params[:login]
    end
    @company = (Company.find(id: params[:company_id].to_i) || @company)
    @email = (params[:email] || @email)
    @password = (params[:password] || @password)
    save!
  end

  def save!
    @user = User.find_by_email(@email)
    validate_email!
    validate_password!
    set_token!
    set_route!
    @user
  end

  def get_route
    @route
  end

  private

  def set_token!
    token = current_api_session_token
    token.user = @user
    @token = token.token
    raise Exceptions::StdError, "Authorization is not accepted!" unless (@token)
  end

  def validate_password!
    raise Exceptions::StdError, "Password is not valid!" unless(_provided_valid_password?)
  end

  def _provided_valid_password?
    @password && UserAuthenticationService.authenticate_with_password!(@user, @password)
  end

  def validate_email!
    raise Exceptions::StdError, "Email is not valid!" unless (@user)
  end
end