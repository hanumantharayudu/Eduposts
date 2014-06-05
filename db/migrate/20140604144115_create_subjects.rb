class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.integer :cls_id
      t.integer :school_admin_id
      t.string :subject_name
      t.timestamps
    end
  end
end
