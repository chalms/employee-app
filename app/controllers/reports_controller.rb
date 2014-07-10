class ReportsController < ApplicationController
  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all

    render json: @reports
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @report = Report.find(params[:id])

    render json: @report
  end

  # POST /reports
  # POST /reports.json
  def create
    @user = current_user
    validate_user_role!
    @report = @user.reports.new(params[:report])

    if @report.save
      render json: @report, status: :created, location: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    @report = Report.find(params[:id])

    if @report.update(params[:report])
      head :no_content
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    head :no_content
  end

  private

  def validate_user_role!
    raise Exceptions::StdError, unless (@user.role == 'manager' || @user.role == 'companyAdmin')
  end

end
