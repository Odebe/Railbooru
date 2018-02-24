class TagAlias < ApplicationRecord
  belongs_to :tag
  belongs_to :alias, class_name: "Tag"
end
