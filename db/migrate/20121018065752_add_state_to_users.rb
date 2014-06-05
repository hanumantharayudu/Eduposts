class AddStateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :state, :string
    add_column :users, :bio, :text
    add_column :users, :major, :string
    add_column :users, :website, :string
  end
end
