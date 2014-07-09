class HomeController < ApplicationController
	def signup 
		flash[:notice] = ""
	end 

	def login
	end 

	def signout 
		current_api_session_token.delete!
		render :sign_up
	end 

	def authenticate 
		puts params

		c = Company.find_by_id(params[:company_id])
		validate_company!(c)
		emp_log = c.employee_logs.where(:employee_number => params[:employee_number])
		validate_employee_logs!(emp_log)

		if (params[:email].present?)
			hash = {  
				:email => params[:email], 
				:name => params[:name], 
				:company_number => c.id,
				:password => params[:password], 
				:role => emp.role
			}
			user = User.create!(hash)
			token = current_api_session_token
			token.user = user
			@user = user 
			@token = token.token
		end 
		@user = UserSerializer.new(user).to_json		
		validate_create_user!
		render :home
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

	def validate_emp_logs!(emp_log)
		raise Exceptions::StdError, "Employee that was given does not match any existing records!" unless emp_log
	end 

	def validate_company!(c)
		raise Exceptions::StdError, "Company does not exist" unless c
	end 

  def validate_create_user! 
    raise Exceptions::StdError, "Token is not valid!" unless (@token)
    raise Exceptions::StdError, "Sorry there must be an error on our end... We are fixing it as quick as possible" unless(@user)
  end 

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