class FakeReport

  def initialize
    fake_project = FakeProject.new
    @project = f_project.fake_project
    @admin = f_project.fake_admin
    @manager = f_project.fake_manager
    @client = f_project.fake_client

    fake_employees = FakeEmployees.new(@manager.company)
    @employees = fake_employees.employees

    @report = @manager.reports.create!({
      'summary' => "This is the report summary",
      'date' => (Date.today+1),
      'client_id' => @client.id,
      'project_id' => @project.id
    })
  end
end