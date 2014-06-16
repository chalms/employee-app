class MessageSerializer < ApplicationSerializer
  attributes :id, :content, :read, :recipient, :delivered, :delivered_at
  has_one  :chat
end
