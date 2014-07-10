class ChangeProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :manager_id
    add_column :projects, :manager_number, :integer
  end

  def down
    remove_column :projects, :manager_number
    add_column :projects, :manager_id, :integer
  end
end
