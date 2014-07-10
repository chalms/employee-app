class EmployeeLog < ActiveRecord::Base
  attr_accessible :name, :employee_number, :role, :company_id
  belongs_to :company
  validates :employee_number, :uniqueness => true
  validate :role_exists

  ROLES = ['companyAdmin', 'manager', 'employee']

  def role_exists
    raise Exceptions::StdError, "Role does not exist" unless(ROLES.include?(role))
  end
end