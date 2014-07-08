class MessageSerializer < ApplicationSerializer
  has_one :photo
  has_one :user, as: :sender 
  has_many :users, as: :group 
  attr_accessible :data, :recipients, :sender, :created_at, :read_by_all
end
