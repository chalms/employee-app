class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :ancestry
      t.string :type
      t.string :data
      t.string :name
      t.boolean :complete
      t.timestamps
    end

    add_index :items, :ancestry

    create_table :reports_items do |t|
      t.belongs_to :report
      t.belongs_to :item
    end

    create_table :users_items do |t|
      t.belongs_to :user
      t.belongs_to :item
    end
  end
end
