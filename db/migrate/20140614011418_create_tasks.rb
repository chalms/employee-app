class CreateTasks < ActiveRecord::Migration
  def change

    create_table :chats do |t|
      t.timestamps
    end

    create_table :clients do |t|
      t.string   :name
      t.string   :email
      t.boolean :complete, :default => false
      t.timestamps
    end

    create_table :photos do |t|
      t.text     :data
      t.timestamps
    end

    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :employee_number
      t.string :password
      t.string :api_secret
      t.string :type
      t.binary :password
      t.string :auth_token
      t.string :role
      t.timestamps
    end

    create_table :users_chats do |t|
      t.belongs_to :user
      t.belongs_to :chat
    end

    add_index :users_chats, [:user_id, :chat_id]

    add_column :clients, :user_id, :integer

    create_table :locations do |t|
      t.string   :address
      t.string   :city
      t.string   :country
      t.string :name
      t.string :type
      t.timestamps
    end

    create_table :messages do |t|
      t.text     :data
      t.integer  :photo_id
      t.integer  :user_id
      t.integer  :chat_id
      t.boolean  :read_by_all, :default => false
      t.timestamps
    end

    add_column :photos, :message_id, :integer
    add_index :photos, :message_id

    create_table :reports do |t|
      t.string   :summary
      t.date     :date
      t.boolean  :complete,   default: false
      t.integer  :client_id
      t.integer  :user_id
    end

    create_table :users_reports do |t|
      t.belongs_to :user
      t.belongs_to :report
      t.datetime :checkin
      t.datetime :checkout
      t.boolean :complete, default: false
      t.integer :location_id
    end

    add_index :users_reports, [:user_id, :report_id]

    create_table :parts do |t|
      t.string  :name
      t.string  :barcode
      t.belongs_to :user
      t.references :client
    end

    create_table :reports_parts do |t|
      t.boolean :complete, false
      t.string :note
      t.datetime :completion_time
      t.belongs_to :part
      t.belongs_to :users_report
      t.timestamps
    end

    add_column :photos, :reports_part_id, :integer

    create_table :tasks do |t|
      t.string   :description
      t.references :client
      t.belongs_to :user
    end

    create_table :reports_tasks do |t|
      t.boolean :complete, :false
      t.string :note
      t.datetime :completion_time
      t.belongs_to :tasks
      t.belongs_to :users_reports
      t.timestamps
    end

    add_column :photos, :reports_task_id, :integer

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

    create_table :contacts do |t|
      t.string :phone
      t.string :email
      t.string :name
      t.belongs_to :user
      t.belongs_to :company
      t.references :client
      t.timestamps
    end

    add_column :users, :contact_id, :integer

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

    create_table :projects_users do |t|
      t.references :user, :project
    end

    create_table :tasks_projects do |t|
      t.references :project, :task
    end

    add_index :tasks_projects, [:task_id, :project_id]

    create_table :users_messages do |t|
      t.belongs_to :users_chat
      t.belongs_to :message
      t.boolean :read, :default => false
    end

    create_table :locations_reports_parts do |t|
      t.references :location, :reports_part
    end

    create_table :locations_reports_tasks do |t|
      t.references :location, :reports_task
    end


    create_table :locations_users_reports do |t|
      t.references :location, :users_report
    end


    create_table :locations_reports do |t|
      t.references :location, :report
    end


    create_table :locations_clients do |t|
      t.references :location, :client
    end


    create_table :employee_logs do |t|
      t.belongs_to :company
      t.string :name
      t.string :employee_number
      t.string :role
    end
  end
end
