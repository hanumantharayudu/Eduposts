class Addassigntosubject < ActiveRecord::Migration
  def up
    add_column :subjects, :assign, :string
  end

  def down
     remove_column :subjects, :assign
  end
end
