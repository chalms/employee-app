class ChatSerializer < ApplicationSerializer
  attributes :id
  has_many  :messages
  has_one :worker 
  has_one :manager
end
