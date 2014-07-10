class FakeReport

  def initialize
    fake_project = FakeProject.new
    @project = f_project.fake_project
    @admin = f_project.fake_admin
    @manager = f_project.fake_manager

    fake_employees = FakeEmployees.new(@manager.company)
    @employees = fake_employees.employees
  end


