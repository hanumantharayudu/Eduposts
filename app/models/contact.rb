class Contact < ActiveRecord::Base
  attr_accessible :name, :email, :message, :send_copy

  validates :name, :email, :message, :presence => true
end
