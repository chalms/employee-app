class CreateClientsProjects < ActiveRecord::Migration
  def change
    create_table :clients_projects do |t|
      t.references :client, :project
      t.timestamps
    end
  end
end
