class ChangeUsersReport < ActiveRecord::Migration
  def change
    add_column :users_reports, :manager_id, :integer
  end
end
