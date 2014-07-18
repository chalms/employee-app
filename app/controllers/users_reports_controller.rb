class UsersReportsController < ApplicationController
  # GET /users_reports
  # GET /users_reports.json
  def index
    @users_reports = UsersReport.all

    render json: @users_reports
  end

  # GET /users_reports/1
  # GET /users_reports/1.json
  def show
    @users_report = UsersReport.find(params[:id])

    render json: @users_report
  end

  # POST /users_reports
  # POST /users_reports.json
  def create
    @report = Report.find(params[:report_id])
    @users_report = @report.users_reports.create!(:user_id => params[:user_id])
    respond_to do |format|
      format.js
    end
  end

  # PATCH/PUT /users_reports/1
  # PATCH/PUT /users_reports/1.json
  def update
    @users_report = UsersReport.find(params[:id])

    if @users_report.update(params[:users_report])
      head :no_content
    else
      render json: @users_report.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users_reports/1
  # DELETE /users_reports/1.json
  def destroy
    @users_report = UsersReport.find(params[:id])
    @users_report.destroy

    head :no_content
  end
end
