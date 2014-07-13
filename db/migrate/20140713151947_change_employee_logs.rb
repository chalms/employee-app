class ChangeEmployeeLogs < ActiveRecord::Migration
  def change
    remove_column :employee_logs, :name
    add_column :employee_logs, :email, :string
  end
end
