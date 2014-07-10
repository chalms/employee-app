class FakeEmployees
  def initialize(company)
    @company = company
    @company.employee_logs.create!({
      'name' => "John Wilson",
      'role' => "employee",
      'employee_number' => "26654"
    })
    @company.employee_logs.create!({
      'name' => "Nancy Bottlinger",
      'role' => "employee",
      'employee_number' => "23354"
    })
    @employees = []
    @employees << @company.users.create!({
      'name' => "John Wilson",
      'employee_number' => "26654",
      'email' => "go-leafs-go@gmail.com",
      'password' => 'goKessel'
    })
    @employees << @company.users.create!({
      'name' => "Nancy Bottlinger",
      'employee_number' => "23354",
      'email' => "greenpeace@exxon.com",
      'password' => 'lexingtonSteele'
    })
  end

  def fake_employees
    @employees
  end

  def fake_company
    @company
  end
end


