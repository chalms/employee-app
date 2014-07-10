class ProjectsController < ApplicationController

  include ActionController::MimeResponds

  def index
    @user = current_user
    @projects = @user.company.projects
    respond_to do |format|
      format.json { render json: @projects};
      format.html { render haml: @projects };
    end
  rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @user = current_user
    @project = @user.company.projects.find_by_id(params[:id])
    validate_permissions!
    respond_to do |format|
      format.json { render json: @project};
      format.html { render haml: @project };
    end
  rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end

  # POST /projects
  # POST /projects.json
  def create
    @user = current_user
    @project = @user.company.projects.create!(params[:project])
    validate_permissions!
    respond_to do |format|
      format.json { render json: @project};
      format.html { render haml: @project };
    end
  rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @project = Project.find(params[:id])
    params = clean!
    validate_permissions!
    puts "updating..."
    @project.update_attributes!(params)
    puts "new project... #{@project.inspect}"
    puts "responding..."
    respond_to do |format|
      format.json { render json: @project.to_json };
      format.html { render haml: @project };
    end
    return
  rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
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
