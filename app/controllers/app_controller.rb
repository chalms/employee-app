class AppController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
#  protect_from_forgery
  # For APIs, you may want to use :null_session instead.
  def logged_in!
  end 

  def logged_out!
  end 

end





