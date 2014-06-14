class ReportsController < ApplicationController

  def show
    ### need to have a request/response pairing here 

    @report = Report.find(params[:id])
    format.json { render :json => @chats.as_json }
  end


  def create
    #~~~~~~~~~~~~~~~~~~ ADMIN
    @report = Report.new(params[:messages])
    if @report.save
      render json: @report, status: :created, location: @report 
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(params[:equipment])
      head :no_content
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  def destroy
    #~~~~~~~~~~~~~~~~~~ ADMIN
    @report = Report.find(params[:id])
    @report.destroy

    head :no_content
  end
end