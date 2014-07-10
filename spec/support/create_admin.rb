class CreateAdmin

  def initialize
  end

  def create_user
    @company = Company.create!({
      :name => "GWPH"
    })
    @company.employee_logs.create!({
      :name => "Andrew",
      :role => "companyAdmin",
      :employee_number => "505696"
    })
    @user = @company.users.create!({
      :name => "Andrew Chalmers",
      :email => "achalme8@uwo.com",
      :password => "password",
      :employee_number => "505696",
      :role => "companyAdmin",
      :company_id => @company.id
    })
    return @user
  end
end