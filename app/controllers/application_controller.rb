class ApplicationController < ActionController::Base

  rescue_from UserAuthenticationService::NotAuthorized, with: :deny_access
  rescue_from Exceptions::StdError, with: :go_home

  private

  def go_home
    if @user
      route!
      respond_to do |format|
        format.html{ render: @route, haml: Signup.new }
        format.json{ render: @route, json: Signup.new }
      end
    else
      respond_to do |format|
        format.html{ render: 'signup/new', haml: Signup.new }
        format.json{ render: 'signup/new', json: Signup.new }
      end
    end
  rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end

  def route!
    if (@user.role == 'companyAdmin')
      admin!
    elsif (@user.role == 'manager')
      manager!
    else
      employee!
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


  def deny_access
    raise Exceptions::StdError, "Invalid login information"
  end

  def signed_in?
    !!current_api_session_token.user
  end

  def current_user
    current_api_session_token.user
  end

  def api_session_token_authenticate!
    return _not_authorized unless _authorization_header && current_api_session_token.valid?
  end

  def current_api_session_token
    @current_api_session_token ||= ApiSessionToken.new(_authorization_header)
  end

  def _authorization_header
    puts request.headers
    puts request.headers.to_s
    request.headers['HTTP_AUTHORIZATION']
  end

  def _not_authorized message = "Not Authorized"
    _error message, 401
  end

  def _not_found message = "Not Found"
    _error message, 404
  end

  def _error message, status
    render json: { error: message }, status: status
  end
end