class Message  < ActiveRecord::Base
  include JsonSerializingModel
  has_one :photo
  belongs_to :user
  belongs_to :chat
  has_many :users_messages
  attr_accessible :data, :sender, :created_at, :read_by_all, :chat_id, :user_id
  after_create :set_recipients

  def sender
    @sender ||= self.user
  end

  def set_recipients
    if (users_messages.andand.count == 0)
      chat.users_chats.each do |u_c|
        if (u_c.user_id == sender.id)
          u_c.users_messages.create!(:message_id => self.id, :read => true)
        else
          u_c.users_messages.create!(:message_id => self.id)
        end
      end
    end
  end

  def read_by_all
    read_by_all = !!@recipients.find(read: false)
  end

  def recipients
    @recipients ||= (users_messages || self.users_messages)
    @recipients ||= UserMessages.where(message_id: self.id)
    @recipients
  end
end