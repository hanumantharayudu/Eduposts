class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.integer :receiver_id
      t.text :body
      t.string :document_content_type
      t.string :document_file_name
      t.integer :document_file_size
      t.datetime :document_updated_at

      t.timestamps
    end
  end
end
