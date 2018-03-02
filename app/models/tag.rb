class Tag < ApplicationRecord
	validates :name, presence: true
	validates :name, uniqueness: true

	has_and_belongs_to_many :posts

  has_many :tag_aliases
  has_many :aliases, through: :tag_aliases
  has_many :inverse_tag_aliases, class_name: "TagAlias", foreign_key: "alias_id"
  has_many :inverse_aliases, through: :inverse_tag_aliases, source: :tag
end
