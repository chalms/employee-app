class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :type
  has_many :reports
  has_many :chats
end
