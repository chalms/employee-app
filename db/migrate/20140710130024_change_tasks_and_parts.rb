class ChangeTasksAndParts < ActiveRecord::Migration
  def change
    drop_table :tasks_projects
    add_column :tasks, :report_id, :integer
    add_column :parts, :report_id, :integer
  end
end
