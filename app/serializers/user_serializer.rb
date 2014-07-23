class UserSerializer < ActiveModel::Serializer
  attributes  :email, :name, :password, :employee_number, :company_id, :company
end