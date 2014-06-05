class Cls < ActiveRecord::Base
 attr_accessible :school_admin_id, :class_name,:subjects,:subjects_attributes, :status
  belongs_to :school_admin
  has_many :subjects, :dependent => :destroy
  has_many :teacherclasses, :dependent => :destroy
  accepts_nested_attributes_for :subjects,  :allow_destroy  => true,:reject_if => :all_blank
end