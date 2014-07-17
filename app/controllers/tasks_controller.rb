class TasksController < ApplicationController
  include ActionController::MimeResponds

  def index
    user!
    admin_manager!
    @data = params[:data]
    @data = { :tasks => params[:tasks], :div => params[:div] } unless @data
    if (@data)
      respond_to do |format|
        format.json { render json: @data }
        format.js
      end
    else
      data = {}
      data[:tasks] = @user.tasks
      data[:name] = @user.name
      respond_to do |format|
        format.json { render json: @data }
        format.js
      end
    end
  end

  def new
    user!
    admin_manager!
    @data = params[:data] || { :owner => 'company', :owner_id => @user.company.id }
    @data[:employees].map! { |e| Employee.find(e.to_i)}
    @data[:owner_id] = @data[:owner].to_i if (@data[:owner].to_i != 0)
    @data[:owner] = UsersReport.find(@data[:owner_id])
    @data[:div] ||= "#new-task"
    @div = @data.delete(:div)
    respond_to do |format|
      format.json { render json: @data }
      format.js
    end
  end

  def show
    user!
    can_view!
    @div = params[:div]
    @task = Task.find(params[:id])
    respond_to do |format|
      format.json { render json: @task }
      format.js
    end
  end

  def create
    user!
    admin_manager!
    puts params
    params = params['task'] || params
    puts params.inspect
    puts params[:users_report]
    puts params[:description]
    @task = create_task(params[:users_report], params[:users_report], { :description => params[:description] } )
    raise Exceptions::StdError, "Error creating task!" unless (@task)
    respond_to do |format|
      format.js
    end
  rescue Exceptions::StdError => e
    flash[:errors] = e.message
    render json: e.message
  end

  def update
    user!
    is_admin_manager!
    @task = Task.find(params[:id])
    if @task.update(params[:task])
      head :no_content
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    user!
    is_admin_manager!
    @task = Task.find(params[:id])
    @task.destroy
    head :no_content
  end

  private

  def create_task(owner, id, hash)
    if owner == 'company'
      return @user.company.create!(hash)
    elsif owner == 'report'
      return @user.andand.reports.find(id).andand.create!(hash)
    elsif owner == 'project'
      return @user.company.andand.clients.find(id).andand.create!(hash)
    elsif owner == 'users_report'
      return @user.andand.users_reports.find(id).andand.create!(hash)
    end
  end

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
