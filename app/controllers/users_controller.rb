class UsersController < ApplicationController
  def index
    puts params
    if (params[:company_id])
      puts "returning users where: "
      u = User.where(:company_id => params[:company_id])
    else
      u = User.all
    end
    @users = {}
    u.each { |us| @users << {:email => us.email, :setup => us.setup}}
    respond_to do |format|
      format.json { render json: @users }
    end
  end
end