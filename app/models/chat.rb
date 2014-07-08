class Chat < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :company 
  has_and_belongs_to_many :users 
  has_many :messages 

  validate :multi_user_unique 

  def multi_user_unique 
    raise Exceptions::StdError, "Something went wrong, hold on [for developers -> chat: no company id]" unless Company.find_by_id(company.id).present?
    raise Exceptions::StdError, "Something went wrong, hold on [for developers -> chat: duplicate chat with same users]" if (Chat.where(:company => company).count > 1) 
    raise Exceptions::StdError, "Chat needs at least two users" if (users.count < 2)
    return true 
  end

  def get_messages
    messages.order_by(:created_at, "DESC")
  end

  def send_message(message_text, message_photo, user_id)
    message_hash = {}
    message_hash[:text] = message_text 

    message = Message.new(sender: user, group: users)
    message.data = message_text 
    message.photo = Photo.create!(:data => message_photo, :message => message) if (message_photo.andand.present?)

    raise Exceptions::StdError, "Message could not be saved!" unless message.save
  end
end 