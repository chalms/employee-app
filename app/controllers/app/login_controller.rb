class App::LoginController < AppController
  def check_sign_up
    logged_out!

    if User.where(email: params[:email]).present?
    #  flash[:error] = "A user with that email already exists"
      raise Exceptions::StdError 
    end

    user = User.create!(:email => params[:email], "password" => params[:password], :name => params[:name], :company_name => params[:company_name])
    
    login_user(user)

    @current_user = current_user

    return redirect_to app_user_url({:id => @current_user.id, :auth_token => @current_user.auth_token, :email => @current_user.email})
  rescue Exceptions::StdError
 #   flash[:error] = "Please fill in all fields correctly"
    return respond :sign_up
  end

  def check_login
    logged_out!
    user = User.where(email: params[:email]).first
    if user.present?
      if user.authenticate(params[:password])
        login_user(user)
        if current_user
          return redirect_to :home
        end
      end
    end
    # flash[:error] = "Invalid email or password"
    return redirect_to :welcome
  end

  def welcome
    logged_out!
  end

  def sign_up
    logged_out!
  end
end

