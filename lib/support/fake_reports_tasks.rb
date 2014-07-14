class FakeReportsTasks
  def initialize(tasks, users_reports)
    @tasks = tasks
    while(@tasks.length > 0)
      users_reports.each do |u_r|
        break if @tasks.length == 0
        task = @tasks.pop
        puts "checking if task assignment is true"
        unless (task.assignment)
          u_r.reports_tasks.create!({
            :task_id => task.id
          })
        end
      end
      puts "next task"
    end
    puts "done fake report tasks"
  end
end