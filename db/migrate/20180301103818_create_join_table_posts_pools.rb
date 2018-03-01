class CreateJoinTablePostsPools < ActiveRecord::Migration[5.1]
  def change
    create_join_table :posts, :pools do |t|
      # t.index [:post_id, :pool_id]
      # t.index [:pool_id, :post_id]
    end
  end
end
