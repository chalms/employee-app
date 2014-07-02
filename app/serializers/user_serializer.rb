class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  has_many :reports
  has_many :chats
end
