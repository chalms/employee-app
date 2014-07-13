class ReportsController < ApplicationController
  # GET /api/reports
  # GET /api/reports.json
  include ActionController::MimeResponds
  def index
    @user = current_user
    is_manager!
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
    is_manager!
    @report = Report.new
    respond_to do |format|
      format.json { render json: @report, status: :success }
      format.html { render haml: @report }
      format.js
    end
  end

  # POST /api/reports
  # POST /api/reports.json
  def create
    @user = current_user
    is_manager!
    params[:report].each { |k,v| params[k] = v if ((params[k]==nil) && (v != nil)) }
    params.each{ |k,v|  v = params[:report][k] unless (v.present? && (k.to_s == "report")) }

    p = params
    if p[:report_date].is_a? String
      date = Date.strptime(p[:report_date], '%m/%d/%Y')
      p[:report_date] = date
    end

    attr_hash = {:date => p[:report_date],  :name => p[:name],  :description => p[:description]}

    r = Report.find_by_id(p[:id])

    if (r.present?)
      @report = r.update_attributes!(attr_hash)
    else
      @report = Report.create!(attr_hash)
    end

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
