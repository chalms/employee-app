class CreateReportsParts < ActiveRecord::Migration
  def change
    create_table :reports_parts do |t|

      t.timestamps
    end
  end
end
