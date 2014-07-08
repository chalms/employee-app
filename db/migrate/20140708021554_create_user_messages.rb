class CreateUserMessages < ActiveRecord::Migration
  def change
    create_table :user_messages do |t|

      t.timestamps
    end
  end
end
