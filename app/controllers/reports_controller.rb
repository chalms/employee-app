class ReportsController < ApplicationController
  # GET /api/reports
  # GET /api/reports.json
  include ActionController::MimeResponds

  def index
    puts "received request"
    @user = current_user
    puts @user.inspect
    puts "ABOVE IS USER"
    validate_user_role!
    puts "params: #{params.inspect}"


    @data = params[:data]
    @data[:reports] = Report.where(params[:options]).order(:date)
    @div = params[:data][:div]

    if (!!@data)
      puts "in @data"
      respond_to do |format|
        puts format.inspect
        format.json { render json: @data, status: :success }
        format.js { }
      end
    else
      puts "in @reports = @user_reports"
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
    @options = params[:options]
    @div = params[:div]
    @data = {}
    @data[:report] = @report
    @data[:options] = @options if (@options)
    @data[:div] = @div if (@div)

    respond_to do |format|
      format.json { render json: @report, status: :success }
      format.js
    end
  end

  def new
    @user = current_user
    validate_user_role!
    @data = {}
    if params[:options]
      @data[:report] = Report.new(params[:options])
      @data[:options] = params[:options]
    end
    @data[:options] =
    @div = params[:div] ||= nil
    @data[:div] = @div if @div
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
    puts "trying to creating report with params: #{params}"
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
