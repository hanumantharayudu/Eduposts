class Favorite < ActiveRecord::Base
  attr_accessible :user_id, :tweet_id,:status
  belongs_to :user
  belongs_to :tweet
end
