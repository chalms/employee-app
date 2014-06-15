class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::StrongParameters
  include ActionController::ImplicitRender
  include CanCan::ControllerAdditions

  before_filter :authenticate_user_from_token!

  # from gem not current using: ~~~~~~~~~~~
  # acts_as_token_authentication_handler_for Admin, fallback_to_devise: false  
  # acts_as_token_authentication_handler_for Users


  #Handle authorization exception from CanCan
  rescue_from CanCan::AccessDenied do |exception|

    render json: {errors: ["Insufficient privileges"]}, status: :forbidden
  end

  #Handle RecordNotFound errors
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: {errors: [exception.message]}, status: :unprocessable_entity
  end


  def authenticate_user_from_token!

    user_email = params[:email].presence
    user       = user_email && User.find_by_email(email)

    if user && Devise.secure_compare(user.authentication_token, params[:auth_token])
      sign_in user, store: false
    end
  end
end 
