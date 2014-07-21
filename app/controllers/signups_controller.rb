class SignupsController < ApplicationController
  include ActionController::MimeResponds

  def new
    puts params.inspect
    begin
      @signup ||= Signup.new
    rescue Exceptions::StdError => e
      @signup = Signup.new
    end
    respond_to do |format|
      format.html { render haml: @signup }
      format.json { render json: @signup }
    end
  end

  def create
    puts params.inspect
    begin
      @signup ||= Signup.new
      @signup.update(params)
      @user = @signup.save!
      set_token!
      @route = route!
      respond_to do |format|
        format.html { render haml: @route }
        format.json { render json: @route }
      end
    rescue Exceptions::StdError => e
      :new
    end
  end

  def set_token!
    token = current_api_session_token
    token.user = @user
    @token = token.token
    raise Exceptions::StdError, "Authorization is not accepted!" unless (@token)
  end

  def _provided_valid_api_session_token?
    params[:api_key] && UserAuthenticationService.authenticate_with_api_key!(@user, params[:api_key], current_api_session_token.token)
  end

  def api_session_token_url(token)
    api_sessions_path(token)
  end
end