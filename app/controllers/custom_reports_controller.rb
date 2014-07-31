class CustomReportsController < ApplicationController
  # GET /custom_reports
  # GET /custom_reports.json
  def index
    @custom_reports = CustomReport.all

    render json: @custom_reports
  end

  # GET /custom_reports/1
  # GET /custom_reports/1.json
  def show
    @custom_report = CustomReport.find(params[:id])

    render json: @custom_report
  end

  # POST /custom_reports
  # POST /custom_reports.json
  def create
    @custom_report = CustomReport.new(params[:custom_report])

    if @custom_report.save
      render json: @custom_report, status: :created, location: @custom_report
    else
      render json: @custom_report.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /custom_reports/1
  # PATCH/PUT /custom_reports/1.json
  def update
    @custom_report = CustomReport.find(params[:id])

    if @custom_report.update(params[:custom_report])
      head :no_content
    else
      render json: @custom_report.errors, status: :unprocessable_entity
    end
  end

  # DELETE /custom_reports/1
  # DELETE /custom_reports/1.json
  def destroy
    @custom_report = CustomReport.find(params[:id])
    @custom_report.destroy

    head :no_content
  end
end
