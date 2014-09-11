class ProjectsController < ApplicationController

  include ActionController::MimeResponds

  def summary
    @user = current_user
    @project = Project.find(params[:project_id])
    @data = params[:data]
    @data[:project] = @project
    @div = params[:data][:div]
   respond_to do |format|
     format.js
   end
  end

  def index
    @user = current_user
    puts @user.inspect
    @projects = @user.company.projects
    respond_to do |format|
      format.json { render json: @projects};
      format.html { render haml: @projects };
      format.js
    end
  rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end

  def show
    puts "in projects/show"
    @user = current_user
    puts params.inspect
    puts @user.inspect
    @project = Project.find(params[:id])
    validate_permissions!
    puts @project.inspect
    respond_to do |format|
      format.json { render json: @project};
      format.html { render haml: @project };
      format.js
    end
  rescue Exceptions::StdError => e
    puts e
    flash[:error] = e.message
  end

  def create
    @user = current_user
    @clients = params[:project][:clients]
    params[:project].delete(:clients)
    @project = @user.company.projects.create!(params[:project])
    @clients.each { |c| ClientsProject.create!({:client_id => c.to_i, :project_id => @project.id})}

    validate_permissions!
    puts @project.inspect
    respond_to do |format|
      format.json { render json: @project};
      format.html { render haml: @project };
    end
  rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end

  def update
    @user = current_user
    @project = Project.find(params[:id])
    validate_permissions!
    params = clean!
    @project.update_attributes!(params)
    respond_to do |format|
      format.json { render json: @project };
      format.html { render haml: @project };
    end
    return
  rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end

  def destroy
    @user = current_user
    @project = Project.find(params[:id])
    validate_permissions!
    @project.destroy
    head 200, :content_type => 'text/html'
  rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end

  private

  def clean!
    params[:project]
  end

  def validate_permissions!
    raise Exceptions::StdError, "Invalid permissions" unless(@project)
  end
end
