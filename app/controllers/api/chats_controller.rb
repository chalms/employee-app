class ChatsController < ApiController
  def create
    return _not_authorized unless signed_in?
    respond_with current_user.chats.create(chat_params)
  end

  def index
    respond_with Chat.published.
      in_reverse_chronological_order.
      paginate(params[:page_number], params[:per_page] || 20)
  end

  def show
    chat = Chat.published.find_by_id(params[:id])
    chat = current_user.chats.find_by_id(params[:id]) if !chat && signed_in?
    return _not_found unless chat
    respond_with chat
  end

  def update
    chat = signed_in? ? current_user.chats.find_by_id(params[:id]) : nil
    return _not_found unless chat
    chat.update_attributes!(chat_params)
    render json: chat
  end

  def destroy
    chat = signed_in? ? current_user.chats.find_by_id(params[:id]) : nil
    return _not_found unless chat
    return _not_authorized unless user.is_manager?
    chat.destroy!
    respond_with chat
  end

  private

  def chat_params
    params.require(:chat).permit(:subject, :body, :manager_id, :worker_id, :published_at)
  end

  def chat_url(chat)
    api_chats_url(chat)
  end
end