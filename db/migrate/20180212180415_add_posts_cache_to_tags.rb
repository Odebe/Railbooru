class AddPostsCacheToTags < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :posts_cache, :integer, default: 0
  end
end
