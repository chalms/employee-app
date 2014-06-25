class ChangeReports < ActiveRecord::Migration
  def change
  	remove_column :reports, :report_date, :date, :null => false 
  	add_column :reports, :report_date, :date
  end
end
