class WorkersController < ApplicationController

  def index
    #~~~~~~~~~~~~~~~~~~
    @workers = Worker.all
    render json: @workers
  end

  def show
    @workers = Worker.find(params[:id])
    render json: @workers
  end


  def create
    #~~~~~~~~~~~~~~~~~~
    @worker = Worker.new(params[:task])
    if @worker.save
      render json: @worker, status: :created, location: @workers
    else
      render json: @worker.errors, status: :unprocessable_entity
    end
  end

  def update
    @workers = Worker.find(params[:id])
    if @workers.update(params[:task])
      head :no_content
    else
      render json: @workers.errors, status: :unprocessable_entity
    end
  end

  def destroy
    #~~~~~~~~~~~~~~~~~~
    @workers = Worker.find(params[:id])
    @workers.destroy

    head :no_content
  end
end
