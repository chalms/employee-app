class HomeController < ApplicationController
	def signup 
		flash[:notice] = ""
	end 

	def login
	end 

	def authenticate 
		puts params
		if (params[:user].present?) 
			if (params[:user][:email].present?)
				hash = {  
					:email => params[:user][:email], 
					:name => params[:user][:name], 
					:company_name => params[:user][:company_name],
					:password => params[:user][:password]
				}
				@user = User.create!(hash)
				token = current_api_session_token
				token.user = @user
			end 
		end 
		raise Exceptions::StdError, "Invalid Params" unless (@user && token)
		redirect_to :home, {:user => @user, :api_session_token => token} 
rescue Exceptions::StdError => e
		puts "error message #{e}"
		flash[:error] = e
		render :action => :sign_up
	end 

	def home 
		@user = current_user 
		puts "home params: #{params}"
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