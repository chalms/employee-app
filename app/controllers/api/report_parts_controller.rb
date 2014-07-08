class ReportPartsController < ApplicationController
  # GET /report_parts
  # GET /report_parts.json
  def index
    @report_parts = ReportPart.all

    render json: @report_parts
  end

  # GET /report_parts/1
  # GET /report_parts/1.json
  def show
    @report_part = ReportPart.find(params[:id])

    render json: @report_part
  end

  # POST /report_parts
  # POST /report_parts.json
  def create
    @report_part = ReportPart.new(params[:report_part])

    if @report_part.save
      render json: @report_part, status: :created, location: @report_part
    else
      render json: @report_part.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /report_parts/1
  # PATCH/PUT /report_parts/1.json
  def update
    @report_part = ReportPart.find(params[:id])

    if @report_part.update(params[:report_part])
      head :no_content
    else
      render json: @report_part.errors, status: :unprocessable_entity
    end
  end

  # DELETE /report_parts/1
  # DELETE /report_parts/1.json
  def destroy
    @report_part = ReportPart.find(params[:id])
    @report_part.destroy

    head :no_content
  end
end
