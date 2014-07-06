class UsersHaveAndBelongToManyRoles < ActiveRecord::Migration
  def self.up
    create_table :roles_users, :id => false do |t|
      t.references :role, :user
    end
  end
 
  def self.down
    drop_table :roles_users
  end
end




      # contact: 
      #   t.string phone 
      #   t.string email 
      #   t.string name 

      # company_contact:  
      #   t.string company_id 
      #   t.string contact_id 

      # company_client: 
      #   t.string company_id 
      #   t.string client_id 

      # company: 
      #   t.string name 
      #   t.integer company_contact_id 
      #   t.integer company_client_id 
      #   t.integer company_project_id 
      #   t.integer company_part_id 
        

      # company_project: 
      #   t.integer company_id
      #   t.integer project_id 

      # company_part: 
      #   t.integer part_id
      #   t.integer company_id 

      # company_task: 
      #   t.integer task_id 
      #   t.integer company_id 