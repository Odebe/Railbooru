class Tag < ApplicationRecord
	validates :name, presence: true
	validates :name, uniqueness: true

	has_and_belongs_to_many :posts

	def self.add_tags(tags)
		tags.each do |tag|
			self.create(name: tag) if self.where(name: tag).count == 0
		end
	end
end
