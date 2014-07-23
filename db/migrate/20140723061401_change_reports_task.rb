class ChangeReportsTask < ActiveRecord::Migration
  def change
    remove_column :reports_tasks, :false, :boolean
    add_column :reports_tasks, :status, :integer, :default => 0
  end
end
