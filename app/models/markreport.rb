class Markreport < ActiveRecord::Base
  attr_accessible :user_id, :receiver_id,:cls_id,:subject_id,:school_admin_id,:min_marks,:max_marks,:total_marks,:result,:comment,:markreport_document
  belongs_to :user
  belongs_to :receiver, :class_name => 'User'
  belongs_to :subject
  belongs_to :cls
end
