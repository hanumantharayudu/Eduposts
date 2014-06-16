class Studentclass < ActiveRecord::Base
 attr_accessible :user_id, :cls_id, :school_admin_id
 belongs_to :user
 belongs_to :cls
 belongs_to :school_admin
end
