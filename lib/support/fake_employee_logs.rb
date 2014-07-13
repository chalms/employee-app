class FakeEmployeeLogs
  def initialize
    @company = FakeCompany.new.fake_company
    puts "fake employee logs"
    @employee_logs = @company.employee_logs.create!({
      :name => "Andrew",
      :role => "companyAdmin",
      :employee_number => "505696"
    })
  end

  def fake_company
    @company
  end

  def fake_employee_logs
    @employee_logs
  end
end