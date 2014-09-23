class CreateReportsTasksPictures < ActiveRecord::Migration
  def change
    create_table :reports_tasks_pictures do |t|
      t.references :reports_task
      t.string :picture
      t.timestamps
    end
  end
end
