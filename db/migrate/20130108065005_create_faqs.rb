class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.integer :user_id
      t.text :question
      t.text :answer
      t.string :question_file_name
      t.string :question_content_type
      t.integer :question_file_size

      t.timestamps
    end
  end
end
