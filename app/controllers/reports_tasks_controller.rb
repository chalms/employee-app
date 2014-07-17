class ReportsTasksController < ApplicationController
  # GET /reports_tasks
  # GET /reports_tasks.json
  include ActionController::MimeResponds
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
    user!
    admin_manager!
    @task = ReportsTask.find(params[:id])
    @task.destroy
    render nothing: true
  end

  private

  def user!
    @user = current_user
  end

  def can_view!
    raise Exceptions::StdError, "Unauthorized" if (@task.company != @user.company)
  end

  def admin_manager!
    raise Exceptions::StdError, "Employee cannot create a task" unless (@user.role.downcase == 'companyadmin' || @user.role.downcase == 'manager')
  end
end
