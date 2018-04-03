class CreateModerateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :moderate_tasks do |t|
      t.integer :task_type
      t.integer :model_type
      t.integer :model_id
      t.references :creator, foreign_key: { to_table: :users }
      t.references :passer, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
