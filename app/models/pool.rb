class Pool < ApplicationRecord
  has_and_belongs_to_many :posts
  belongs_to :user
  validates :name, presence: true, uniqueness: true

  def posts_string
    self.post_ids.to_s.gsub(/[,\[\]]/,"")
  end
end
