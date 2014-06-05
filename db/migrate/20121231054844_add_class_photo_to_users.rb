class AddClassPhotoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :class_photo_file_name, :string
    add_column :users, :class_photo_content_type, :string
    add_column :users, :class_photo_file_size, :integer
    add_column :users, :class_theme,:string
  end
end
