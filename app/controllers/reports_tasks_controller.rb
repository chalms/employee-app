class ReportsTasksController < ApplicationController
  # GET /reports_tasks
  # GET /reports_tasks.json
  include ActionController::MimeResponds
  def index
    @user = current_user
    @reports_tasks = ReportsTask.all

    render json: @reports_tasks
  end

  # GET /reports_tasks/1
  # GET /reports_tasks/1.json
  def show
    @user = current_user
    @reports_task = ReportsTask.find(params[:id])

    render json: @reports_task
  end

  # POST /reports_tasks
  # POST /reports_tasks.json
  def create
    @user = current_user
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
    @user = current_user
    puts "params => #{params}"
    @reports_task = ReportsTask.find(params[:id])
    puts "attempting to update => #{params[:reports_task]}"
    if @reports_task.update(params[:reports_task])
      # if @reports_task.users_report
      #   report = @reports_task.users_report
      #   report.update_attribute(:checkin, @reports_task.updated_at)  if (!report.checkin)
      # end
      respond_to do |format|
        format.json { render status: 200, json: @reports_task.to_json }
      end
    else
      puts @reports_task.errors
      respond_to do |format|
        format.json {  render json: @reports_task.errors, status: :unprocessable_entity }
      end
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
