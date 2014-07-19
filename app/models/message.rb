class Message  < ActiveRecord::Base
  include JsonSerializingModel
  has_one :photo
  belongs_to :user
  belongs_to :chat
  has_many :users_chats, through: :chat
  has_many :users_messages, through: :users_chats
  attr_accessible :data, :sender, :created_at, :read_by_all, :chat_id, :user_id, :read_by
  after_create :set_recipients

  def sender
    @sender ||= self.user
  end

  def set_recipients
    if (users_messages.andand.count == 0)
      users_chats.each do |uc|
        if (uc.user_id == sender.id)
          uc.users_messages.create!(:message_id => self.id, :read => true)
        else
          uc.users_messages.create!(:message_id => self.id)
        end
      end
    end
  end

  def status
    if (read_by_all)
      @status = "read"
    else
      @status = "read by #{read_by}"
    end
  end

  def read_by
    recipients.where(read: true).count
  end

  def read_by_all
    read_by_all = (recipients.where(read: false).count > 0)
  end

  def recipients
    @recipients ||= (users_messages || UserMessages.where(message_id: self.id))
    @recipients
  end
end