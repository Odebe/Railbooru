class AddMd5ToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :md5, :string
  end
end
