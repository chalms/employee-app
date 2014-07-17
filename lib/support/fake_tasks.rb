class FakeTasks
  def initialize(f_report)
    @tasks = []
    @tasks << f_report.fake_report.tasks.create({
      :description => "Sand benches"
    })
    @tasks << f_report.fake_project.tasks.create({
      :description => "Nail bleachers"
    })
  end

  def fake_tasks
    @tasks
  end
end
