class UsersChat  < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :chat
  belongs_to :user
  attr_accessible :user_id, :chat_id
  has_many :users_messages

  def read_all?
    self.users_messages.find(:read, false).present?
  end

  def unread
    self.users_messages.where(:read, false)
  end
end