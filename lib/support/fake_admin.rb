class FakeAdmin
  def initialize
    @company = FakeEmployeeLogs.new.fake_company
    puts "fake admin"
    puts "#{@company.id}"
    puts @company.inspect
    puts @company.users.count
    @admin = @company.users.create!({
      :name => "Andrew Chalmers",
      :email => "achalme8@uwo.com",
      :password => "password",
      :employee_number => "505696",
      :role => "companyAdmin",
      :company_id => @company.id
    })
  end

  def fake_admin
    return @admin
  end

  def fake_company
    return @company
  end
end