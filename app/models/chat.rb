class Chat < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :company
  has_many :users_chats
  has_many :users, :through => :users_chats
  has_many :messages
  attr_accessible :company_id, :type, :name
  after_create :has_owner
  TYPES = ['UsersReportsChat', 'ReportsChat']

  def has_owner
    raise Exceptions::StdError, "Chat has no owner" unless (type != nil || !!self.company_id )
    return true
  end

  def company
    if (!!self.company)
      @company ||= self.company
    else
      @company ||= Company.find(self.company_id)
    end
  end

  def get_messages
    messages.order_by(:created_at, "DESC")
  end

  def name
    str = ""
    names = {}
    users.each { |u| names[u.name] = u.id }
    lock = false
    names.each do |k, v|
      if (lock)
        str += "& #{k}"
      else
        str += "#{k}"
        lock = true
      end
    end
    @name = str
  end

  def send_message(message_text, message_photo, user_id)
    message_hash = {}
    message_hash[:text] = message_text
    message = Message.create!(user_id: user_id, chat_id: id)
    message.data = message_text
    raise Exceptions::StdError, "Message could not be saved!" unless message.save
    message
  end
end