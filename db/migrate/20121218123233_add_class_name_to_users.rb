class AddClassNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :class_name,:string
    add_column :users, :syllabus,:text
    add_column :users, :class_description,:text
  end
end
