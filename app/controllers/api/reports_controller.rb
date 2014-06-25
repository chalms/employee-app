class Api::ReportsController < ApiController
  # GET /api/reports
  # GET /api/reports.json

  include ActionController::MimeResponds
  def index
    @api_reports = Report.all

    render json: @api_reports
  end

  # GET /api/reports/1
  # GET /api/reports/1.json
  def show
    puts params
    @api_report = Report.find(params[:id])

    respond_with json: @api_report, status: :success
  end

  def new 
    @api_report = Report.new
    respond_with json: @api_report
  end 

  # POST /api/reports
  # POST /api/reports.json
  def create
    puts params
    @api_report = Report.new(params[:api_report])
    if @api_report.save
      respond_to do |format| 
        format.json { render json: @api_report};
      end 
    end
  end

  # PATCH/PUT /api/reports/1
  # PATCH/PUT /api/reports/1.json
  def update
    @api_report = Report.find(params[:id])

    if @api_report.update(params[:api_report])
     render json: @api_report, status: :success
    else
      render json: @api_report.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/reports/1
  # DELETE /api/reports/1.json
  def destroy
    @api_report = Report.find(params[:id])
    @api_report.destroy

    head :no_content
  end
end
