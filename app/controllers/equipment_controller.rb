class EquipmentController < ApplicationController

  def show
    @workers = Equipment.find(params[:id])
    render json: @workers
  end


  def create
    #~~~~~~~~~~~~~~~~~~
    @workers = Equipment.new(params[:equipment])
    if @workers.save
      render json: @workers, status: :created, location: @workers
    else
      render json: @workers.errors, status: :unprocessable_entity
    end
  end

  def update
    @workers = Equipment.find(params[:id])
    if @workers.update(params[:equipment])
      head :no_content
    else
      render json: @workers.errors, status: :unprocessable_entity
    end
  end

  def destroy
    #~~~~~~~~~~~~~~~~~~
    @workers = Equipment.find(params[:id])
    @workers.destroy

    head :no_content
  end
end