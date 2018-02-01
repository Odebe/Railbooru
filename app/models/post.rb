class Post < ApplicationRecord
	#validates :name

	has_and_belongs_to_many :tags
	has_many :comments

	#accept_nested_attributes_for :comments

	mount_uploader :image, ImageUploader

	def add_tags(tags)
  	tags.each do |tag|
    	tag = Tag.where(name: tag).first
      if tag
        self.tags << tag unless self.tags.include? tag
      end
    end
  end

  def remove_tags(tags)
    self.tags.each do |tag|
      self.tags.delete(tag) unless tags.include? tag.name
    end
  end

  def has_sample?
  	self.samp
  end
end
