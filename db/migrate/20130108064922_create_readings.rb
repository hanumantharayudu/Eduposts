class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.integer :user_id
      t.integer :school_admin_id
      t.integer :cls_id
      t.integer :subject_id
      t.text :title
      t.text :reading
      t.string :read_document_file_name
      t.string :read_document_content_type
      t.integer :read_document_file_size

      t.timestamps
    end
  end
end
