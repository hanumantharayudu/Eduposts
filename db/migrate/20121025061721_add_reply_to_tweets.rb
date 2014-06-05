class AddReplyToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :reply, :boolean
    add_column :tweets, :tweet_id, :integer
  end
end
