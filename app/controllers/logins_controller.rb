class LoginsController < ApplicationController

  include ActionController::MimeResponds
  include AppHelper

  def new
    begin
      @login ||= Login.new
  rescue Exceptions::StdError => e
      puts e.message
      @login = Login.new
    end
    respond_to do |format|
      format.html { render haml: @login }
      format.json { render json: @login }
    end
  end

  def create
    begin
      @login ||= Login.new
      @login.update(params)
      @user = @login.save!
      puts "LoginsController [@user]: #{@user.inspect}"
      set_token!
      @user.api_session_token = @token
      puts "LoginsController [@user.token]: #{@user.inspect}"
      @route = route!
      puts "LoginsController [@user.inspect]: #{@user.inspect}"
      respond_to do |format|
        format.html{ render haml: @route }
        format.json{ render json: @route }
      end
      return
    rescue Exceptions::StdError => e
      puts e
      flash[:error] = e
      @login = nil
      render :new
    end
  end

  def logout
    @user = current_user
    current_api_session_token.delete!
    render :new
  end

  private
  def set_token!
    token = current_api_session_token
    puts "THE TOKEN IS: #{token.inspect}"
    @token = { :token => token.token, :ttl => token.ttl }
    puts "AND NOW IT IS: #{@token.inspect}"
    raise Exceptions::StdError, "Authorization is not accepted!" unless (@token)
  end

  def _provided_valid_api_session_token?
    params[:api_key] && UserAuthenticationService.authenticate_with_api_key!(@user, params[:api_key], current_api_session_token.token)
  end

  def api_session_token_url(token)
    api_sessions_path(token)
  end
end