class Subject < ActiveRecord::Base
  attr_accessible :school_admin_id, :class_id,:subject_name,:assign
  belongs_to :school_admin
  belongs_to :cls
  has_many :teacherclasses,:dependent => :destroy
  has_many :faqs,:dependent => :destroy
  has_many :teachertweets,:dependent => :destroy
  has_many :markreports,:dependent => :destroy
end
