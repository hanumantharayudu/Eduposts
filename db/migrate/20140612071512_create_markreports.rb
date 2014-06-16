class CreateMarkreports < ActiveRecord::Migration
  def change
    create_table :markreports do |t|
      t.integer :user_id
      t.integer :cls_id
      t.integer :subject_id
      t.integer :receiver_id
      t.integer :school_admin_id
      t.integer :min_marks
      t.integer :max_marks
      t.integer :total_marks
      t.string :result
      t.text :comment
      t.string :markrepot_file_name
      t.string :markrepot_content_type
      t.integer :markrepot_file_size
      t.timestamps
    end
  end
end
