class TagAlias < ApplicationRecord
  validates :tag_id, presence: true
  validates :alias_id, presence: true

  belongs_to :tag
  belongs_to :alias, class_name: "Tag"
  #belongs_to :tag, class_name: "Tag"
end
