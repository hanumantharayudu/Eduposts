class AddPostBoxToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :post_box,:string
  end
end
