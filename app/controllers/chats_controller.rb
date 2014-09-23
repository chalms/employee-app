class ChatsController < ApplicationController
  include ActionController::MimeResponds
  def index
    @user = current_user
    the_response = @user.users_chats_to_json
    puts "#{the_response}"
    render json: the_response
  end

  def show
    @user = current_user
    puts params
    id = params[:id]
    @data = {}
    @div = params[:div] || '#active-chats'
    @users_chats = @user.users_chats.find(id)
    @data[:messages] = @users_chats.users_messages
    @data[:name] = @users_chats.name
    @data[:id] = id
    respond_to do |format|
      format.json { render json: @messages.to_json }
      format.js
    end
  end

  def new_message
    id = params[:id]
    users_chat = UsersChat.find(id)
    message = users_chat.chat.send_message(params[:text], nil, users_chat.user.id)
    # hash = {}
    # hash = {:message => "<p>#{message.data}</p>"}
    Pusher['#{users_chat.id}'].trigger('greet', {
      :greeting => "#{message.data}!"
    })
    # respond_to do |format|
    #   format.json { render json: hash.to_json }
    # end
    head :ok
    return
  rescue Exceptions::StdError => e
    respond_to do |format|
      format.json { render json: {"error" => "Message could not be sent"}}
    end
  end
end
