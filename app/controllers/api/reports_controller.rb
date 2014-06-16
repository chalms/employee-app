class ReportsController < ApiController
  def create
    return _not_authorized unless signed_in? 
    return _not_authorized unless user.is_manager
    respond_with current_user.reports.create(report_params)
  end

  def index
    is_manager = signed_in ? current_user.is_manager : nil
    if (is_manager) 
      respond_with reports.published.
        in_reverse_chronological_order.
        paginate(params[:page_number], params[:per_page] || 20)
    else 
      reports = current_user.reports
      render json: reports
    end 
  end

  def show
    report = signed_in? ? current_user.reports.find_by_id(params[:id]) : nil
    if report.present? 
      respond_with report if (current_user.is_manager || current_user.is_admin) 
      respond_with report.as_json if (report.report_date == Date.Today) 
    end 
    return _not_found unless report.present?
    render json: report; 
  end

  def update
    report = signed_in? ? current_user.reports.find_by_id(params[:id]) : nil
    return _not_found unless report
    report.update_attributes!(report_params)
    render json: report
  end

  def destroy
    report = signed_in? ? Report.find_by_id(params[:id]) : nil
    return _not_found unless report 
    return _not_authorized unless current_user.is_admin?
    report.destroy!
    respond_with 
  end

  private

  def report_params
    params.require(:report).permit(:manager, :report_date, :tasks)
  end

  def report_url(chat)
    api_report_url(chat)
  end
end