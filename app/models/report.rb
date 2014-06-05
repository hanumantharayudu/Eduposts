class Report < ActiveRecord::Base
  attr_accessible :user_id,:receiver_id,:status, :body
  belongs_to :user
  validates :body, :presence => true
  after_create :report

  def report
    admin_email = Admin.first.email
    UserMailer.send_report(self,admin_email).deliver
  end
end
