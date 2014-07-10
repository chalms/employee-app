class ReportsPartsController < ApplicationController
  # GET /reports_parts
  # GET /reports_parts.json
  def index
    @reports_parts = ReportsPart.all

    render json: @reports_parts
  end

  # GET /reports_parts/1
  # GET /reports_parts/1.json
  def show
    @reports_part = ReportsPart.find(params[:id])

    render json: @reports_part
  end

  # POST /reports_parts
  # POST /reports_parts.json
  def create
    @reports_part = ReportsPart.new(params[:reports_part])

    if @reports_part.save
      render json: @reports_part, status: :created, location: @reports_part
    else
      render json: @reports_part.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reports_parts/1
  # PATCH/PUT /reports_parts/1.json
  def update
    @reports_part = ReportsPart.find(params[:id])

    if @reports_part.update(params[:reports_part])
      head :no_content
    else
      render json: @reports_part.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reports_parts/1
  # DELETE /reports_parts/1.json
  def destroy
    @reports_part = ReportsPart.find(params[:id])
    @reports_part.destroy

    head :no_content
  end
end
