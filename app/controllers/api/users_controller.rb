class Api::UsersController < ApiController

  skip_before_filter :api_session_token_authenticate!, only: [:create]
  def index
    return _not_authorized unless current_user.is_admin?
  end
  
  def show
    user = User.find_by_id(params[:id])

    return _not_found unless user
    return _not_authorized unless (current_user.is_manager || current_user.is_admin || (current_user == user))
    respond_with json: user
  end

  def create 
    puts params
    @user = User.create!(params[:user]) 
    if (@user) 
      return render Session.create!(params[:user])
    end 
  end
end
