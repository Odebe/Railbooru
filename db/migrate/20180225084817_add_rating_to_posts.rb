class AddRatingToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :rating, :integer, default: 2
  end
end
