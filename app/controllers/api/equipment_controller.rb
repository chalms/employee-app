class Api::EquipmentController < ApiController

  def create
    return _not_authorized unless signed_in? 
    return _not_authorized unless current_user.is_manager?
    respond_with current_user.equipment.create(chat_params)
  end

  def index
    equipment = users_daily_equipment
    respond_with equipment
      in_reverse_chronological_order.
      paginate(params[:page_number], params[:per_page] || 20)
  end

  def show
    equipment = signed_in? ? users_daily_equipment.find_by_id(params[:id]) : nil 
    return _not_found unless equipment
    respond_with equipment
  end

  def update
    equipment = signed_in? ? users_daily_equipment.find_by_id(params[:id]) : nil 
    return _not_found unless equipment
    render json: equipment
  end

  def destroy
    equipment = signed_in? ? current_user.equipment.find_by_id(params[:id]) : nil
    return _not_found unless equipment
    return _not_authorized unless user.is_manager?
    equipment.destroy!
    respond_with equipment
  end

  private

  def users_daily_equipment
    return current_user.reports.find_by(report_date: Date.today).map { |r| r.equipment }
  end 

  def equipment_params
    params.require(:equipment).permit(:note, :description, :part_name, :scanned_at, :completed, :published_at)
  end

  def equipment_url(chat)
    api_equipment_url(chat)
  end
end