class ChangeQuestionToFaq < ActiveRecord::Migration
  def up
    remove_column :faqs, :question_file_name
    remove_column :faqs, :question_content_type
    remove_column :faqs, :question_file_size
    add_column :faqs, :question_document_file_name, :string
    add_column :faqs, :question_document_content_type, :string
    add_column :faqs, :question_document_file_size, :integer
  end

  def down
    add_column :faqs, :question_file_name, :string
    add_column :faqs, :question_content_type, :string
    add_column :faqs, :question_file_size, :integer
    remove_column :faqs, :question_document_file_name
    remove_column :faqs, :question_document_content_type
    remove_column :faqs, :question_document_file_size
  end
end
