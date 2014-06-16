class Teachertweet < ActiveRecord::Base
  attr_accessible :user_id, :subject_id, :cls_id, :school_admin_id, :receiver_id, :tweet_id
  belongs_to :user
  belongs_to :receiver, :class_name => 'User'
  belongs_to :subject
  belongs_to :cls
  belongs_to :tweet
end
