class Chat < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :company
  has_many :users_chats
  has_many :users, :through => :users_chats
  has_many :messages
  attr_accessible :company_id, :id
  after_create :multi_user_unique

  def multi_user_unique
    raise Exceptions::StdError, "Something went wrong, hold on [for developers -> chat: no company id]" unless Company.find_by_id(company_id).present?
    return true
  end

  def get_messages
    messages.order_by(:created_at, "DESC")
  end

  def send_message(message_text, message_photo, user_id)
    message_hash = {}
    message_hash[:text] = message_text

    message = Message.create!(user_id: user_id, chat_id: id, group: users)
    message.data = message_text
    # message.photo = Photo.create!(:data => message_photo, :message => message) if (message_photo.andand.present?)

    raise Exceptions::StdError, "Message could not be saved!" unless message.save
  end
end