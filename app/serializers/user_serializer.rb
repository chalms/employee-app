class UserSerializer < ActiveModel::Serializer
  attributes :email, :name, :password_digest, :employee_number, :hours, :days_worked, :id, :role_ids 
  has_one :role
  has_many :reports
  has_many :chats
end