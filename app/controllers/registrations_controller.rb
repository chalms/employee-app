# class Api::RegistrationsController < Api::BaseController
  
#   respond_to :json
#   def create
 
#     worker = Worker.new(params[:user])
#     if worker.save
#       render :json=> worker.as_json(:auth_token=> worker.authentication_token, :email=>user.email), :status=>201
#       return
#     else
#       warden.custom_failure!
#       render :json=> worker.errors, :status=>422
#     end
#   end
# end