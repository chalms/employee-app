class ContactSerializer < ActiveModel::Serializer
  attributes :phone, :email, :name, :owner
end
