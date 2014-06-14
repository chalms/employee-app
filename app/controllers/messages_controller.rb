class MessagesController < ApplicationController

  def show
    @message = Message.find(params[:id])
    render json: @message
  end


  def create
    #~~~~~~~~~~~~~~~~~~ ADMIN
    @message = Message.new(params[:messages])
    if @message.save
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  def update
    @message = Message.find(params[:id])
    if @message.update(params[:equipment])
      head :no_content
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  def destroy
    #~~~~~~~~~~~~~~~~~~ ADMIN
    @message = Message.find(params[:id])
    @message.destroy

    head :no_content
  end
end