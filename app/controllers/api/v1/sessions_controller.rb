class Api::V1::SessionsController < Devise::SessionsController  
  def create  
    puts params.to_s
    respond_to do |format|  
      format.html { super }  
      warden.authenticate(:scope => resource_name, :store => false, :recall => "#{controller_path}#new")  
      format.json {  
        render :status => 200, 
        :json => { 
          :success => true,
          :info => "Logged in",
          :data => { 
            :auth_token => current_user.authentication_token 
          } 
        }
      }  
    end  
  end  

  def destroy  
    super  
  end  

  private 
  def sign_in_params
    puts params.to_s
    params.fetch(:user).permit([:password, :email, :id, :authentication_token])
  end
end 
# end  
# class SessionsController < Devise::SessionsController
#         prepend_before_filter :require_no_authentication, :only => [ :create ]
#         respond_to :json

#   def create
#     build_resource(params)
#     resource.role = 'user'
#     warden.authenticate(:scope => resource_name, :store => false, :recall => "#{controller_path}#failure")
#      unless (current_user.present?)
#       sign_in resource, store: false
#     end
#     render :status => 200, :json => { :success => true, :info => "Logged in", :data => { :auth_token => current_user.authentication_token } }
#   end
# end
# module Api
#   module V1
#     module CustomDevise
#       class SessionsController < Devise::SessionsController
#         # prepend_before_filter :require_no_authentication, :only => [:create ]
#         # include Devise::Controllers::Helpers
 
#         # respond_to :json
 
#         # def create
#         #   puts User.count
#         #   warden.authenticate!(:scope => resource_name, :store => false, :recall => "#{controller_path}#failure")
#         #   # puts resource.to_s

#         #    render :status => 200,
#         #           :json => { :success => true,
#         #           :info => "Logged in",
#         #           :data => { :auth_token => current_user.authentication_token } }

#         #   # sign_in resource, store: false
#         #   # resource.update_attribute(authentication_token: nil)
#         #   # resource.save
#         #   # render json: {
#         #   #   auth_token: resource.authentication_token,
#         #   #   worker_role: resource.role
#         #   # }
#         # end
 
#         # def destroy
#         #   sign_out(resource_name)
#         # end

#       end
#     end
#   end
# end