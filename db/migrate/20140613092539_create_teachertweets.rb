class CreateTeachertweets < ActiveRecord::Migration
  def change
    create_table :teachertweets do |t|
      t.integer :user_id
      t.integer :school_admin_id
      t.integer :receiver_id
      t.integer :subject_id
      t.integer :cls_id
      t.integer :tweet_id
      t.timestamps
    end
  end
end
