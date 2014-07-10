class UserSerializer < ActiveModel::Serializer
  attributes :email, :name, :password, :employee_number, :hours, :days_worked, :id, :company_id
  has_many :reports
  has_many :chats
  has_one :company
end