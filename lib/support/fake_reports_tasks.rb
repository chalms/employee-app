class FakeReportsTasks
  def initialize(tasks, users_reports)
    @tasks = tasks
    while(@tasks.length > 0)
      users_reports.each do |u_r|
        task = @tasks.pop
        unless (task.assignment)
          puts u_r.inspect
          u_r.reports_tasks.create!({
            :task_id => task.id
          })
        end
      end
    end
  end
end