class ChangeReportsTasks < ActiveRecord::Migration
  def change
    remove_column :reports_tasks, :users_reports_id, :integer
    add_column :reports_tasks, :users_report_id, :integer
  end
end
