class Api::UsersController < ApiController
  include ActionController::MimeResponds
  skip_before_filter :api_session_token_authenticate!, only: [:create, :new]
  def index
    return _not_authorized unless current_user.is_admin?
  end
  
  def show
    user = User.find_by_id(params[:id])
    return _not_found unless user
    return _not_authorized unless (current_user.is_manager || current_user.is_admin || (current_user == user))
    respond_to do |format| 
      format.json { render json: user };
      format.html { render haml: user};
    end 
  end

  def create 
    @user = User.create!(params[:user]) 
    if @user 
      token = current_api_session_token
      token.user = @user if _provided_valid_password? || _provided_valid_api_session_token?
      respond_to do |format| 
        format.json { render json: user };
        format.html { render 'show' };
      end 
    else 
      redirect_to root_url
    end  
  end

  def new 
    user = User.new 
    respond_to do |format| 
      format.json { render json: user };
      format.html { render haml: "users/new.html.haml"};
    end 
  end 

  private 
  
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
