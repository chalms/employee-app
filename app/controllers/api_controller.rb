class ApiController < ApplicationController
  
  skip_before_action :verify_authenticity_token
  respond_to :json
  rescue_from UserAuthenticationService::NotAuthorized, with: :_not_authorized
  before_filter :api_session_token_authenticate!
  
end
