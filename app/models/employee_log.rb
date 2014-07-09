class EmployeeLog < ActiveRecord::Base 
  attr_accessible :name, :employee_number, :role
  belongs_to :company 
end 