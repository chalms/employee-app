class Api::UsersController < ApiController

  def index
  	if user.is_admin? 
  		 respond_with User.all
  	else 
  		return _not_authorized 
  	end 
  end

  def show
    user = User.find_by_id(params[:id])
    return _not_found unless user
    return _not_authorized unless (current_user.is_manager || current_user.is_admin || (current_user == user))
    respond_with user
  end
end
