class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
    format.json { render :json => @chats.as_json }
  end

  def update
    @chat = Chat.find(params[:id])
    if @chats.update(params[:chat)
      head :no_content
    else
      render json: @chats.errors, status: :unprocessable_entity
    end
  end
end