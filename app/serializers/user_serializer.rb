class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :company_name, :type
  has_many :reports
  has_many :chats
end
