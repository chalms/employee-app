class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, 
  has_one :role
  has_many :reports
  has_many :chats
end
