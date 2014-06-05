class AddFirstNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :role, :string
    add_column :users, :school_admin_id,:integer
  end
end
