class MessageSerializer < ApplicationSerializer
  has_one :photo
  has_many :users_messages, as: :group
  attributes :data, :recipients, :sender, :created_at, :read_by_all, :chat_id, :user_id
end
