class UsersChat  < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :chat 
  belongs_to :user
end