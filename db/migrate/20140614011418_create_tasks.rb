class CreateTasks < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email 
      t.string :company_name 
      t.string :password
      t.string :api_secret
      t.string :type 
      t.timestamps
    end 

    create_table :location do |t|
      t.string :address
      t.string :city
      t.string :country
      t.string :time_of_retrieval 
      t.timestamps
    end

    create_table :client do |t|
      t.string :name
      t.string :email
      t.timestamps
    end

    create_table :client_locations do |t|
      t.belongs_to :client 
      t.references :location 
    end 

    create_table :reports do |t|
      t.string :description
      t.date :report_date, :null => false 
      t.references :location, as: :checkin
      t.references :location, as: :checkout
      t.boolean :completed, :default => false
      t.references :client
      t.timestamps
    end

    create_table :user_reports do |t|
      t.belongs_to :user
      t.belongs_to :report
    end 

    add_index :user_reports, [:user_id, :report_id]

    create_table :tasks do |t|
      t.string :note
      t.belongs_to :report
      t.string :description
      t.boolean :completed, :default => false 
      t.references :location, as: :completed_location
      t.timestamps
    end

    create_table :parts do |t|
      t.string :part_name 
      t.string :barcode
      t.boolean :scanned, :default => false 
    end 

    create_table :task_parts do |t|
      t.belongs_to :task
      t.belongs_to :part
    end 

    add_index :task_parts, [:task_id, :part_id]

    create_table :photos do |t|
      t.text :data 
      t.references :task
      t.timestamps
    end 

    create_table :task_photos do |t|
      t.belongs_to :task
      t.references :photo
    end 

    add_index :task_photos, [:task_id, :photo_id]

    create_table :chats do |t|
      t.timestamps
    end 

    create_table :user_chats do |t|
      t.belongs_to :user
      t.references :chat
      t.timestamps
    end

    add_index :user_chats, [:user_id, :chat_id]

  	create_table :messages do |t|
      t.text :content 
      t.boolean :delivered 
      t.boolean :read
      t.belongs_to :chat
      t.integer :user_id, as: :sender 
      t.timestamps
    end
  end
end
