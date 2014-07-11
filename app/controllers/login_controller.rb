class LoginController < ApplicationController
  include ApplicationController::MimeResponds

  def new
    begin
      @login ||= Login.new
      flash[:notice] = ""
    rescue Exceptions::StdError => e
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
      flash[:notice] = ""
      @login.update(params)
      @user = @login.save!
      route!
      respond_to do |format|
        format.html { render haml: @route }
        format.json { render json: @route }
      end
    rescue Exceptions::StdError => e
      :new
    end
  end

private

  def _provided_valid_api_session_token?
    params[:api_key] && UserAuthenticationService.authenticate_with_api_key!(@user, params[:api_key], current_api_session_token.token)
  end

  def api_session_token_url(token)
    api_sessions_path(token)
  end
end