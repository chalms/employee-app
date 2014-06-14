class ManagersController < ApplicationController

  def show
    @manager = Manager.find(params[:id])
    render json: @manager
  end


  def create
    #~~~~~~~~~~~~~~~~~~ ADMIN
    @manager = Manager.new(params[:managers])
    if @manager.save
      render json: @manager, status: :created, location: @manager
    else
      render json: @manager.errors, status: :unprocessable_entity
    end
  end

  def update
    @manager = Manager.find(params[:id])
    if @manager.update(params[:equipment])
      head :no_content
    else
      render json: @manager.errors, status: :unprocessable_entity
    end
  end

  def destroy
    #~~~~~~~~~~~~~~~~~~ ADMIN
    @manager = Manager.find(params[:id])
    @manager.destroy

    head :no_content
  end
end