class AddUserReportsIdToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :users_reports_id, :integer
  end
end
