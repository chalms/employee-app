class UserSerializer < ActiveModel::Serializer
  attributes :email, :name, :password, :employee_number, :hours, :days_worked, :id, :company_id, :company
  has_one :contact
  has_many :users_reports
  has_many :users_chats
  has_many :chats, :through => :users_chats
  has_many :reports, :through => :users_reports
  has_many :projects, :through => :reports
  has_many :users_messages
  has_many :messages, :through => :users_messages

end