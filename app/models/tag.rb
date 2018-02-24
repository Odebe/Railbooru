class Tag < ApplicationRecord
	validates :name, presence: true
	validates :name, uniqueness: true

	has_and_belongs_to_many :posts
  has_many :tag_aliases#, class_name: 'aliases', foreign_key: 'alias_id'
  has_many :aliases, through: :tag_aliases
end
