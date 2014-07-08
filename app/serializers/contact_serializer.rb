class ContactSerializer < ActiveModel::Serializer
  attributes :phone, :email, :name, :owner
  belongs_to :company 
  belongs_to :user 
end
