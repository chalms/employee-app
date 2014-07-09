class UsersMessage  < ActiveRecord::Base
  include JsonSerializingModel
  belongs_to :message 
  belongs_to :user

  attr_accessible :read
end 
