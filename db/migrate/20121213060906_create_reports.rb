class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :user_id
      t.integer :receiver_id
      t.text  :body
      t.string :status
      t.timestamps
    end
  end
end
