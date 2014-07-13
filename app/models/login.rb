class Login
  attr_reader :email, :password
  include AppHelper

  def initialize
    @email = ""
    @password = ""
    @route = ""
  end

  def update(params)
    if (params[:login])
      params = params[:login]
    end
    @email = (params[:email] || @email)
    @password = (params[:password] || @password)
    return save!
  end

  def save!
    @user = User.find_by_email(@email)
    validate_email!
    validate_password!
    return @user
  end

  private

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