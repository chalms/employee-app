class ReportTasksController < ApplicationController
  # GET /report_tasks
  # GET /report_tasks.json
  def index
    @report_tasks = ReportTask.all

    render json: @report_tasks
  end

  # GET /report_tasks/1
  # GET /report_tasks/1.json
  def show
    @report_task = ReportTask.find(params[:id])

    render json: @report_task
  end

  # POST /report_tasks
  # POST /report_tasks.json
  def create
    @report_task = ReportTask.new(params[:report_task])

    if @report_task.save
      render json: @report_task, status: :created, location: @report_task
    else
      render json: @report_task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /report_tasks/1
  # PATCH/PUT /report_tasks/1.json
  def update
    @report_task = ReportTask.find(params[:id])

    if @report_task.update(params[:report_task])
      head :no_content
    else
      render json: @report_task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /report_tasks/1
  # DELETE /report_tasks/1.json
  def destroy
    @report_task = ReportTask.find(params[:id])
    @report_task.destroy

    head :no_content
  end
end
