class Post < ApplicationRecord
	#validates :name

	has_and_belongs_to_many :tags
	has_many :comments
  belongs_to :user
  

  before_destroy do
    comments.each {|comment| comment.destroy }
  end

	#accept_nested_attributes_for :comments

	mount_uploader :image, ImageUploader

  def has_sample?
  	self.samp
  end
  
end
