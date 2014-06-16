class Tweet < ActiveRecord::Base
  belongs_to :user
  belongs_to :receiver, :class_name => 'User'
  has_many :teachertweets,:dependent => :destroy
  attr_accessible :user_id,:receiver_id, :body,:document,:reply,:tweet_id,:post_box
  validates :body, :presence => true
  has_attached_file :document, :styles => {:medium => "300x300>", :thumb => "100x100>"} if Rails.env == 'development'
  has_attached_file :document,
    :whiny => false,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "uploaded_files/profile/:id/:style/:basename.:extension",
    :bucket => "edupost",
    :styles => {
    :original => "900x900>",
    :default => "280x190>",
    :other => "96x96>" } if (Rails.env == 'production')
  before_post_process :resize_images
  has_one :favorite, :dependent => :destroy

  # Helper method to determine whether or not an attachment is an image.
  def image?
    document_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
  end

  private

  def resize_images
    return false unless image?
  end
end

