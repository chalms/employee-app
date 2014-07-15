class UsersMessage  < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :message
  belongs_to :users_chat
  attr_accessible :read
end
