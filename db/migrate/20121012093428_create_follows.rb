class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :user_id
      t.integer :receiver_id
      t.boolean :status
      t.timestamps
    end
  end
end
