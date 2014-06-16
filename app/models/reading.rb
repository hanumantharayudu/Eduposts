class Reading < ActiveRecord::Base
  attr_accessible :title, :reading, :user_id,:read_document,:_destroy
  attr_accessor :_destroy
  validates :title, :reading,:presence => true
  belongs_to :user
  belongs_to :subject
  has_attached_file :read_document,
    :whiny => false,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "uploaded_files/profile/:id/:style/:basename.:extension",
    :bucket => "edupost",
    :styles => {
    :original => "900x900>",
    :default => "280x190>",
    :other => "96x96>" } if (Rails.env == 'production')
  has_attached_file :read_document,:styles => {:original => "900x900>", :default => "280x190>" } if Rails.env == 'development'

  before_post_process :resize_images

  # Helper method to determine whether or not an attachment is an image.
  def image?
    read_document_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
  end

  private

  def resize_images
    return false unless image?
  end
end
