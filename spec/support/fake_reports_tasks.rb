class FakeReportsTasks
  def initialize(tasks, users_reports)
    @tasks = tasks
    while(@tasks.length > 0)
      users_reports.each do |u_r|
        task = @tasks.pop
        unless (task.assignment)
          users_reports.reports_tasks.create!({
            :task_id => task
          })
        end
      end
    end
  end
end