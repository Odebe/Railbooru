class Alias < ApplicationRecord
  belongs_to :tag
  #validates :name, presence: true
end
