class UsersMessage  < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :message
  belongs_to :users_chat
  attr_accessible :read, :message_id

  def text
    @text ||= message.data
  end

  def status
    @status ||= message.status
  end

  def message
    @message = Message.find(self.message_id) if (self.message_id)
    @message ||= Message.new
  end
end
