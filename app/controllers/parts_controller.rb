class PartsController < ApplicationController
  # GET /parts
  # GET /parts.json
  def index
    @parts = Part.all

    render json: @parts
  end

  # GET /parts/1
  # GET /parts/1.json
  def show
    @part = Part.find(params[:id])

    render json: @part
  end

  # POST /parts
  # POST /parts.json
  def create
    @part = Part.new(params[:part])

    if @part.save
      render json: @part, status: :created, location: @part
    else
      render json: @part.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /parts/1
  # PATCH/PUT /parts/1.json
  def update
    @part = Part.find(params[:id])

    if @part.update(params[:part])
      head :no_content
    else
      render json: @part.errors, status: :unprocessable_entity
    end
  end

  # DELETE /parts/1
  # DELETE /parts/1.json
  def destroy
    @part = Part.find(params[:id])
    @part.destroy

    head :no_content
  end
end
