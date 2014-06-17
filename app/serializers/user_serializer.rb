class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email
  has_many :reports
  has_many :chats
end
