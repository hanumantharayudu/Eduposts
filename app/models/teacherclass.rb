class Teacherclass < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :cls
  belongs_to :subject
end
