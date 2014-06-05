class Follow < ActiveRecord::Base
  attr_accessible :user_id, :receiver_id,:status
  belongs_to :user
  belongs_to :receiver, :class_name => 'User'
end
