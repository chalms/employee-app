class AddAncestryToReportsTasks < ActiveRecord::Migration
  def change
    add_column :reports_tasks, :ancestry, :string
  end
end
