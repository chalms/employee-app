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
    @users_report = UsersReport.new(params[:users_report])

    if @users_report.save
      render json: @users_report, status: :created, location: @users_report
    else
      render json: @users_report.errors, status: :unprocessable_entity
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
