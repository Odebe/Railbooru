class AddReffs < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :moderate_tasks, :users, column: :creator_id, primary_key: :id
    add_foreign_key :moderate_tasks, :users, column: :passer_id, primary_key: :id
  end
end
