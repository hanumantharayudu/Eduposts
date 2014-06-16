class CreateImportentLinks < ActiveRecord::Migration
  def change
    create_table :importent_links do |t|
      t.integer :user_id
      t.integer :school_admin_id
      t.integer :cls_id
      t.integer :subject_id
      t.text :title
      t.text :links
      t.string :link_file_name
      t.string :link_content_type
      t.integer :link_file_size

      t.timestamps
    end
  end
end
