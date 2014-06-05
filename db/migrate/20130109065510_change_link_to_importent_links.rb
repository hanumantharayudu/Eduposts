class ChangeLinkToImportentLinks < ActiveRecord::Migration
  def up
    remove_column :importent_links, :link_file_name
    remove_column :importent_links, :link_content_type
    remove_column :importent_links, :link_file_size
    add_column :importent_links, :link_document_file_name, :string
    add_column :importent_links, :link_document_content_type, :string
    add_column :importent_links, :link_document_file_size, :integer
  end

  def down
    add_column :importent_links, :link_file_name, :string
    add_column :importent_links, :link_content_type, :string
    add_column :importent_links, :link_file_size, :integer
    remove_column :importent_links, :link_document_file_name
    remove_column :importent_links, :link_document_content_type
    remove_column :importent_links, :link_document_file_size
  end
end
