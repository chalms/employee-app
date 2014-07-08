class CreateReportTasks < ActiveRecord::Migration
  def change
    create_table :report_tasks do |t|

      t.timestamps
    end
  end
end
