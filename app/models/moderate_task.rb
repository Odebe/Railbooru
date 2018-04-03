class ModerateTask < ApplicationRecord
  enum task_type: [:creation, :deletion, :edition]
  enum model_type: [:post, :pool, :tag_alias]
  enum status: [:open, :close]
  
  belongs_to :creator, class_name: 'User'
  belongs_to :passer, class_name: 'User', optional: true

  validates :passer, presence: false
end
