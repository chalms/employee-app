class AddAssignedToTasksAndParts < ActiveRecord::Migration
  def change
    add_column :tasks, :assigned, :boolean
    add_column :parts, :assigned, :boolean
  end
end
