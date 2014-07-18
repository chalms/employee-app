class TasksController < ApplicationController
  include ActionController::MimeResponds


  def index
    user!
    admin_manager!
    @data = params[:data]
    @data = { :tasks => params[:tasks] } unless @data
    if (@data[:div])
      @div = @data[:div]
    else
      @div = params[:div]
    end
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
    puts "IN NEW"
    user!
    admin_manager!
    @data = params[:data] || { :owner => 'company', :owner_id => @user.company.id }
    @data[:employees].map! { |e| Employee.find(e.to_i)}
    @data[:owner_id] = @data[:owner].to_i if (@data[:owner].to_i != 0)
    @data[:owner] = UsersReport.find(@data[:owner_id])
    @div = @data[:div] || params[:div]
    @data[:div] = @div if (@div.present? && (!@data[:div]))
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
    @data = {task: @task}
    respond_to do |format|
      format.json { render json: @task }
      format.js
    end
  end

  def create
    puts "IN CREATE"
    user!
    admin_manager!
    puts "Params: #{params}"
    puts params.class.name
    @data = {}
    @div = params['div']
    @task = create_task('users_report', params['users_report'], { :description => params['description'] } )
    @data[:task] = @task
    @data[:users_report] = params['users_report']
    @data[:description] = params['description']
    @data[:employees] = params['employees']

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
    admin_manager!
    @task = Task.find(params[:id])
    @task.destroy
    render nothing: true
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
      users_report = UsersReport.find(id.to_i)
      hash[:users_report] = users_report
      return create_with_task_and_users_report(hash)
    end
  end

  def create_with_task_and_users_report(hash)
    raise Exceptions::StdError, "Must add a description!" unless (hash[:description])
    task = Task.create!({:description => hash[:description], :report_id => hash[:users_report].report.id, :user_id => hash[:users_report].user.id})
    ReportsTask.create!({:task_id => task.id, :users_report_id => hash[:users_report].id})
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
