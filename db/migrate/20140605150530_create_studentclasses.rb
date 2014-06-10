class CreateStudentclasses < ActiveRecord::Migration
  def change
    create_table :studentclasses do |t|
      t.integer :user_id
      t.integer :cls_id
      t.integer :school_admin_id
      t.timestamps
    end
  end
end
