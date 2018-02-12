class ChangePostsCacheToPostsCount < ActiveRecord::Migration[5.1]
  def change
    rename_column :tags, :posts_cache, :posts_count
  end
end
