class ChangeLocationClients < ActiveRecord::Migration
  def change
    drop_table :locations_clients
    add_column :locations, :client_id, :integer
  end
end
