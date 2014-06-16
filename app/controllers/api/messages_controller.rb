class MessagesController < ApiController

  def create
    return _not_authorized unless signed_in?
    if (current_user.chats.first.manager_id == current_user.id)
      needed_symbol = worker_id:
      unneeded_symbol = manager_id:
    else 
      unneeded_symbol = worker_id:
      needed_symbol = manager_id:
    end                    #this way we have for example: chats.find_by(manager_id: 3)
    chat = current_user.chats.find_by(needed_symbol params(:recipient_id))
    if (!chat.present?) 
      chat = current_user.chats.create!(needed_symbol params(:recipient_id), unneeded_symbol params(:id))
    end 
    theMessage = Message.find_by(chat.messages.create!(params))
    theMessage.update_attributes!(:delivered => true, :delivered_at => DateTime.new) if (theMessage.present?)
    render theMessage
  end

  def index
    return _not_authorized unless signed_in?
    if (current_user.chats.first.manager_id == current_user.id)
      needed_symbol = worker_id:
      unneeded_symbol = manager_id:
    else 
      unneeded_symbol = worker_id:
      needed_symbol = manager_id:
    end   
    respond_with current_user.chats.find_by(needed_symbol params(:recipient_id)).messages
      in_reverse_chronological_order.
      paginate(params[:page_number], params[:per_page] || 20)
  end

  def show
    return _not_authorized unless signed_in? 
    message = Message.find_by(:id)
    return _not_found unless message
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => message }
    end
  end

  def update
    return _not_authorized unless signed_in? 
    message = Message.find_by(:id)
    return _not_found unless message
    message.update_attributes!()
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => message }
    end
  end

  def destroy
    message = signed_in? ? Message.find_by_id(params[:id]) : nil
    return _not_found unless message 
    return _not_authorized unless current_user.is_admin?
    message.destroy!
    respond_with json: { status:  200 }
  end

  private
  def message_params
    params.require(:chat).permit(:body, :delivered, :delivered_at, :read, :recipient, :manager_id, :worker_id, :published_at)
  end

  def message_url(chat)
    api_message_url(chat)
  end
end