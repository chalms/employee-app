class Api::TaskController < ApiController

  def create
    return _not_authorized unless signed_in? 
    return _not_authorized unless current_user.is_manager?
    respond_with current_user.tasks.create(chat_params)
  end

  def index
    task = users_daily_task
    respond_with task
      in_reverse_chronological_order.
      paginate(params[:page_number], params[:per_page] || 20)
  end

  def show
    task = signed_in? ? users_daily_task.find_by_id(params[:id]) : nil 
    return _not_found unless task
    respond_with task
  end

  def update
    task = signed_in? ? users_daily_task.find_by_id(params[:id]) : nil 
    return _not_found unless task
    render json: task
  end

  def destroy
    task = signed_in? ? current_user.task.find_by_id(params[:id]) : nil
    return _not_found unless task
    return _not_authorized unless user.is_manager?
    task.destroy!
    respond_with task
  end

  private

  def users_daily_task
    return current_user.reports.find_by(report_date: Date.today).map { |r| r.task }
  end 

  def task_params
    params.require(:task).permit(:note, :description, :completed, :completed_at, :published_at)
  end

  def task_url(chat)
    api_task_url(chat)
  end
end