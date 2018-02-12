class Post < ApplicationRecord
	has_and_belongs_to_many :tags, counter_cache: true
	has_many :comments, dependent: :destroy
  belongs_to :user
  
	#accept_nested_attributes_for :comments

	mount_uploader :image, ImageUploader
end
