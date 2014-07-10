class FakeReport

  def initialize
    f_project = FakeProject.new
    @project = f_project.fake_project
    @admin = f_project.fake_admin
    @manager = f_project.fake_manager
    @client = f_project.fake_client
    @report = @manager.reports.create!({
      'summary' => "This is the report summary",
      'date' => (Date.today+1),
      'client_id' => @client.id,
      'project_id' => @project.id
    })
  end

  def fake_project
    @project
  end

  def fake_admin
    @admin
  end

  def fake_manager
    @manager
  end

  def fake_client
    @client
  end

  def fake_report
    @report
  end

end