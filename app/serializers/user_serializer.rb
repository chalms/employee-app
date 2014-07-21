class UserSerializer < ActiveModel::Serializer
  attributes :email, :name, :password, :employee_number, :hours, :days_worked, :id, :company_id, :company, :assigned_reports, :completed_reports


end