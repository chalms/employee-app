class App::UsersController < AppController
  def show
    if (current_user.present?)
      puts current_user
    else 
      puts "#{cookies.to_s}"
    end 
    
    @current_user = current_user
  rescue Exceptions::StdError => e
    @error_message = e.message
  end

  def logout
    if current_user.present?
      logout_user
    end
    # return redirect_to(sign_up_path)
  end  
end 