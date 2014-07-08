class CreateTasks < ActiveRecord::Migration
  def change

  create_table :chats do |t|
    t.timestamps
  end

  create_table :clients do |t|
    t.string   :name
    t.string   :email
    t.timestamps
  end

  create_table :locations do |t|
    t.string   :address
    t.string   :city
    t.string   :country
    t.belongs_to :client
    t.timestamps
  end


  create_table :photos do |t|
    t.text     :data
    t.timestamps
  end 

  # need to add {belongs to}

  create_table :messages do |t|
    t.text     :content
    t.integer  :photo_id 
    t.integer  :user_id
    t.boolean  :read_by_all
    t.timestamps 
  end

  add_column :photos, :message_id, :integer 
  add_index :photos, :message_id 

  # need to add belongs_to and {has and belongs to }

  create_table :users do |t|
    t.string :name
    t.string :email 
    t.integer :employee_number 
    t.string :password
    t.string :api_secret
    t.string :type 
    t.binary :password 
    t.string :auth_token 
    t.timestamps
  end 

  create_table :reports do |t|
    t.string   :summary 
    t.date     :date
    t.boolean  :complete,   default: false
    t.integer  :location_id
    t.integer  :client_id
    t.integer  :user_id 
  end

  create_table :user_reports do |t|
    t.belongs_to :user
    t.belongs_to :report
    t.datetime :checkin 
    t.datetime :checkout 
    t.boolean :complete, default: false 
    t.integer :location_id
  end 

  add_index :user_reports, [:user_id, :reports_id]

  create_table :parts do |t|
    t.string  :name
    t.string  :barcode
  end

  create_table :report_parts do |t|
    t.boolean :complete, false
    t.string :note 
    t.datetime :completion_time
    t.belongs_to :parts
    t.belongs_to :user_reports
    t.integer :photo_id 
    t.integer :location_id
    t.timestamps
  end

  add_index :report_parts, [:user_report_id, :part_id]
  add_column :photos, :report_part_id, :integer 

  create_table :tasks do |t|
    t.string   :description
  end

  create_table :report_tasks do |t|
    t.boolean :complete, :false
    t.string :note
    t.datetime :completion_time
    t.belongs_to :tasks
    t.belongs_to :user_reports
    t.integer :photo_id 
    t.integer :location_id 
    t.timestamps
  end

  add_index :report_tasks, [:user_report_id, :task_id]
  add_column :photos, :report_task_id, :integer 

  create_table :companies do |t|
    t.timestamps
  end

  create_table :contacts do |t|
    t.string :phone
    t.string :email
    t.string :name
    t.belongs_to :user
    t.belongs_to :company
    t.timestamps 
  end 
  
  create_table :projects do |t|
    t.timestamps
  end

  create_table :user_messages do |t|
    t.belongs_to :user 
    t.belongs_to :messages
  end 

  add_index :user_messages, [:user_id, :message_id]

  create_table :roles do |t|
    t.string :name
    t.timestamps
  end

  create_table :roles_users do |t|
    t.references :role, :user
  end

  end
end
