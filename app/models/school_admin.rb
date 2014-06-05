class SchoolAdmin < ActiveRecord::Base
  extend FriendlyId
  friendly_id :school_name, use: [:slugged, :history]
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,:admin_id, :remember_me,:first_name,:last_name,:school_name,:reset_password_token
  validates :school_name,:first_name,:last_name, :presence => true
  validates_uniqueness_of :school_name
  has_many :users, :dependent => :destroy
  has_many :clses, :dependent => :destroy
  has_many :subjects, :dependent => :destroy
  validate :email_should_not_exist_in_student,:email_should_not_exist_in_admin

  def email_should_not_exist_in_student
    student = User.find_by_email(self.email)
    return true unless student.present?
    self.errors.add(:email, "is already taken")
    return false
  end

  def email_should_not_exist_in_admin
    student = Admin.find_by_email(self.email)
    return true unless student.present?
    self.errors.add(:email, "is already taken")
    return false
  end

  def generate_password_reset_code
    self.reset_password_token = Digest::SHA2.hexdigest(Time.now.to_s)
    self.reset_password_sent_at = Time.now
    save
  end

  def school
    self.school_name.split(".").join("").downcase
  end
end
