class ChangeTaskIdInReportsTasks < ActiveRecord::Migration
  def change
    remove_column :reports_tasks, :tasks_id, :integer
    add_column :reports_tasks, :task_id, :integer
  end
end
