class UsersChat  < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :chat
  belongs_to :user
  attr_accessible :user_id, :chat_id
  has_many :users_messages

  def read_all?
    users_messages.find(:read, false).present?
  end

  def unread
    users_messages.where(read: false)
  end

  def name
    @name ||= nil
    unless @name
      str = ""
      lock = true
      chat.users.each do |u|
        if (u.id != user.id)
          str += ", #{u.name}" unless lock
          if lock
            str += u.name
            lock = false
          end
        end
      end
      @name = str
    end
    @name
  end

  def chat
    @chat ||= Chat.find(self.chat_id)
  end
end