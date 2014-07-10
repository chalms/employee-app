class FakeProject
  def initialize
    fake_manager = FakeManager.new

    @admin = fake_manager.fake_admin
    @manager = fake_manager.fake_manager
    @company = @admin.fake_company

    @project = @company.projects.create!({
      "company_id" => @company.id,
      "start_date" => Date.today,
      "end_date"   => (Date.today+100),
      "manager_number" => @manager.id,
      "budget" => 100000.0,
      "clients" => [fake_manager.fake_client],
      "name" => "Project X"
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

  def fake_company
    @company
  end

end
