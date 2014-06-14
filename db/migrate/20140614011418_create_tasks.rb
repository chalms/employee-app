class CreateTasks < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.string :first_name
      t.string :last_name 
      t.string :company_name
      t.timestamps
    end

    create_table :tasks do |t|
      t.string :description
      t.boolean :completed 
      t.datetime :completed_at 
      t.string :note
      t.text :photo 
      t.timestamps
    end

    create_table :reports do |t|
      t.string :description
      t.date :report_date, :null => false 
      t.datetime :checkin 
      t.datetime :checkout 
      t.boolean :completed, :default => false
      t.references :manager, :null => false 
      t.timestamps
    end

    change_table :tasks do |t|
    	t.references :report
    	t.integer :report_index
	  end 

	  create_table :equipment do |t|
      t.string :description, :null => false 
      t.string :barcode 
      t.text :photo 
      t.string :part_name, :null => false  
      t.references :report, :null => false 
      t.integer :report_index
      t.boolean :completed 
      t.timestamps
    end

    create_table :workers do |t|
      t.string :first_name 
      t.string :last_name 
      t.string :company_name
      t.timestamps
    end

    change_table :reports do |t|
    	t.references :worker, :null => false 
    end 

    create_table :chats do |t|
      t.references :manager, :null => false
      t.references :worker, :null => false
      t.timestamps
    end

    add_index :chats, [:manager_id, :worker_id], :unique => true
  	
  	create_table :messages do |t|
      t.text :content 
      t.boolean :delivered 
      t.references :chat
      t.timestamps
    end

    create_table :clients do |t|
      t.string :name
      t.string :email
      t.timestamps
    end

    change_table(:reports, :id => false) do |t|
      t.references :clients
    end


    create_table :geo_locations do |t|
      t.string :address
      t.string :city
      t.string :country
      t.timestamps
    end

    change_table :tasks do |t| 
      t.references :geo_locations
    end 

    change_table :equipment do |t| 
      t.references :geo_locations
    end 

    change_table :clients do |t| 
      t.references :geo_locations
    end 

    add_column :messages, :recipient, :integer
  end
end
