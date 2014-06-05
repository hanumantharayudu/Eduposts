class AddSyllabusLinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :syllabus_link_file_name, :string
    add_column :users, :syllabus_link_content_type, :string
    add_column :users, :syllabus_link_file_size, :integer
  end
end
