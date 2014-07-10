class ReportsTasksController < ApplicationController
  # GET /reports_tasks
  # GET /reports_tasks.json
  def index
    @reports_tasks = ReportsTask.all

    render json: @reports_tasks
  end

  # GET /reports_tasks/1
  # GET /reports_tasks/1.json
  def show
    @reports_task = ReportsTask.find(params[:id])

    render json: @reports_task
  end

  # POST /reports_tasks
  # POST /reports_tasks.json
  def create
    @reports_task = ReportsTask.new(params[:reports_task])

    if @reports_task.save
      render json: @reports_task, status: :created, location: @reports_task
    else
      render json: @reports_task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reports_tasks/1
  # PATCH/PUT /reports_tasks/1.json
  def update
    @reports_task = ReportsTask.find(params[:id])

    if @reports_task.update(params[:reports_task])
      head :no_content
    else
      render json: @reports_task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reports_tasks/1
  # DELETE /reports_tasks/1.json
  def destroy
    @reports_task = ReportsTask.find(params[:id])
    @reports_task.destroy

    head :no_content
  end
end
