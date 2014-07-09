class CreateTasks < ActiveRecord::Migration
  def change
    
    create_table :chats do |t|
      t.timestamps
    end


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :clients do |t|
      t.string   :name
      t.string   :email
      t.boolean :complete, :default => false
      t.timestamps
    end
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :photos do |t|
      t.text     :data
      t.timestamps
    end 
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :users do |t|
      t.string :name
      t.string :email 
      t.string :employee_number 
      t.string :password
      t.string :api_secret
      t.string :type 
      t.binary :password 
      t.string :auth_token
      t.timestamps
    end 
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :user_chats do |t|
      t.belongs_to :user 
      t.belongs_to :chat
    end

    add_index :user_chats, [:user_id, :chat_id]
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    add_column :clients, :user_id, :integer
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :locations do |t|
      t.string   :address
      t.string   :city
      t.string   :country
      t.string :name 
      t.string :type
      t.timestamps
    end
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :messages do |t|
      t.text     :data
      t.integer  :photo_id 
      t.integer  :user_id
      t.integer  :chat_id
      t.boolean  :read_by_all, :default => false 
      t.timestamps 
    end
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    add_column :photos, :message_id, :integer 
    add_index :photos, :message_id 
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :reports do |t|
      t.string   :summary 
      t.date     :date
      t.boolean  :complete,   default: false
      t.integer  :client_id
      t.integer  :user_id 
    end
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :user_reports do |t| 
      t.belongs_to :user
      t.belongs_to :report
      t.datetime :checkin 
      t.datetime :checkout 
      t.boolean :complete, default: false 
      t.integer :location_id
    end 

    add_index :user_reports, [:user_id, :report_id]
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :parts do |t|
      t.string  :name
      t.string  :barcode
      t.belongs_to :user
      t.references :client
    end
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :report_parts do |t|
      t.boolean :complete, false
      t.string :note 
      t.datetime :completion_time
      t.belongs_to :part
      t.belongs_to :user_report
      t.timestamps
    end
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    add_column :photos, :report_part_id, :integer 
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :tasks do |t|
      t.string   :description
      t.references :client 
      t.belongs_to :user 
    end
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :report_tasks do |t|
      t.boolean :complete, :false
      t.string :note
      t.datetime :completion_time
      t.belongs_to :tasks
      t.belongs_to :user_reports
      t.timestamps
    end
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    add_column :photos, :report_task_id, :integer 
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :companies do |t|
      t.string :name
      t.integer :company_admin
      t.boolean :complete, :default => false
      t.integer :company_id
      t.timestamps
    end

    add_column :users, :company_id, :integer
    add_column :clients, :company_id, :integer 
    add_column :parts, :company_id, :integer 
    add_column :tasks, :company_id, :integer
    add_column :chats, :company_id, :integer 
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :contacts do |t|
      t.string :phone
      t.string :email
      t.string :name
      t.belongs_to :user
      t.belongs_to :company
      t.references :client
      t.timestamps 
    end 
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    add_column :users, :contact_id, :integer
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :projects do |t|
      t.string :name 
      t.date :start_date 
      t.date :end_date 
      t.float :budget 
      t.boolean :complete, :default => false
      t.belongs_to :company
      t.belongs_to :client 
      t.timestamps
    end

    add_column :reports, :project_id, :integer 
    add_column :parts, :project_id, :integer
    add_column :tasks, :project_id, :integer

    create_table :project_users do |t|
      t.references :user, :project
    end 
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :task_projects do |t|
      t.references :project, :task 
    end 

    add_index :task_projects, [:task_id, :project_id]
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :user_messages do |t|
      t.belongs_to :user
      t.belongs_to :message
      t.boolean :read, :default => false 
    end 

    add_index :user_messages, [:user_id, :message_id]
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :roles do |t|
      t.string :name
      t.timestamps
    end
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :roles_users do |t|
      t.references :role, :user
    end
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :location_report_parts do |t|
      t.references :location, :report_part 
    end 

    add_index :location_report_parts, [:location_id, :report_part_id]

    create_table :location_report_tasks do |t|
      t.references :location, :report_task
    end 

    add_index :location_report_tasks, [:location_id, :report_task_id]

    create_table :location_user_reports do |t|
      t.references :location, :user_report
    end 

    add_index :location_user_reports, [:location_id, :user_report_id]
    
    create_table :location_reports do |t|
      t.references :location, :report
    end 

    add_index :location_reports, [:location_id, :report_id]

    create_table :location_clients do |t|
      t.references :location, :client 
    end 

    add_index :location_clients, [:location_id, :client_id]

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    create_table :employee_logs do |t|
      t.belongs_to :company 
      t.string :name 
      t.string :employee_number
      t.string :role
    end
  end
end
