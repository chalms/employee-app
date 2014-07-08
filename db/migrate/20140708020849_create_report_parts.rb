class CreateReportParts < ActiveRecord::Migration
  def change
    create_table :report_parts do |t|

      t.timestamps
    end
  end
end
