class ReportsController < ApplicationController
  # GET /api/reports
  # GET /api/reports.json
  include ActionController::MimeResponds
  def index
    @user = current_user
    validate_user_role!
    @div = params[:div]
    @data = params[:data]
    if (!!@data)
      respond_to do |format|
        format.json { render json: @data, status: :success }
        format.js
      end
    else
      @reports = @user.reports
      respond_to do |format|
        format.json { render json: @reports, status: :success }
        format.js
      end
    end
  end

  # GET /api/reports/1
  # GET /api/reports/1.json
  def show
    @user = current_user
    puts params
    @report = Report.find(params[:id])
    respond_to do |format|
      format.json { render json: @report, status: :success }
      format.js
    end
  end

  def new
    @user = current_user
    validate_user_role!
    params = (params[:report] || params)
    @div = params[:div] ||= nil
    @data = params[:data]
    validate_user_role!
    respond_to do |format|
      format.json { render json: @report, status: :success }
      format.html { render haml: @report }
      format.js
    end
  end

  def create
    @user = current_user
    validate_user_role!
    @div = params.delete(:div) if (params[:div])
    @report = @user.add_report(params)
    if @report
      respond_to do |format|
        format.json { render json: @api_report};
        format.html { render haml: @report }
        format.js
      end
    end
  end

  def table
    @user = current_user
    @data = params[:data]
    respond_to do |format|
      format.json { render json: @data }
      format.js
    end
  end

  def update
    @user = current_user
    @report = Report.find(params[:id])
    if @report.update(params[:report])
      respond_to do |format|
        format.json {render json: @report, status: :success }
        format.html {render haml: @report }
        format.js
      end
    else
      respond_to do |format|
        format.json {render @report.errors status: :unprocessable_entity  }
        format.html {render haml: @report }
        format.js { head 500 }
      end
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    head :no_content
rescue Exceptions::StdError => e
    head 500
  end


  private

  def validate_user_role!
    raise Exceptions::StdError, "Invalid permission to access" unless (@user.role == 'manager' || @user.role == 'companyAdmin')
  end

end
