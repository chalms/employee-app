class ChatsController < ApplicationController
  include ActionController::MimeResponds
  def index
    @user = current_user
    @users_chats = []
    @user.users_chats.each do |u_c|
      name = "#{u_c.name[0...10]}..." if (u_c.name.length > 13)
      @users_chats << { :name => name, :id => u_c.id, :unread_count => u_c.unread.count }
    end
    respond_to do |format|
      # if json error remember to 'require JSON'
      format.json { render json: @users_chats.to_json }
      format.js
    end
  end

  def show
    @user = current_user
    id = params[:id]
    @messages = @user(id)
    respond_to do |format|
      format.json { render json: @messages.to_json }
      format.js
    end
  end

  def new_message
    message = params[:message]
  end

end
