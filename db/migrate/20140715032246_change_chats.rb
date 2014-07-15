class ChangeChats < ActiveRecord::Migration
  def change
    add_column :chats, :report_id, :integer
    add_column :chats, :users_report_id, :integer
    add_column :chats, :name, :integer
    add_column :chats, :type, :string
  end
end
