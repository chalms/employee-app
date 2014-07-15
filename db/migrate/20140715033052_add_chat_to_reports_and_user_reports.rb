class AddChatToReportsAndUserReports < ActiveRecord::Migration
  def change
    add_column :users_reports, :chat_id, :integer
    add_column :reports, :chat_id, :integer
  end
end
