class UsersChat  < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :chat
  belongs_to :user
  attr_accessible :user_id, :chat_id
end