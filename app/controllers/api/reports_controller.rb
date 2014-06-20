class Api::ReportsController < ApiController
  # GET /api/reports
  # GET /api/reports.json
  def index
    @api_reports = Report.all

    render json: @api_reports
  end

  # GET /api/reports/1
  # GET /api/reports/1.json
  def show
    @api_report = Report.find(params[:id])

    render json: @api_report
  end

  # POST /api/reports
  # POST /api/reports.json
  def create
    @api_report = Report.new(params[:api_report])

    if @api_report.save
      render json: @api_report, status: :created, location: @api_report
    else
      render json: @api_report.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/reports/1
  # PATCH/PUT /api/reports/1.json
  def update
    @api_report = Report.find(params[:id])

    if @api_report.update(params[:api_report])
      head :no_content
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
