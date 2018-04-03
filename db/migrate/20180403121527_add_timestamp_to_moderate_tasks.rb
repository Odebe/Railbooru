class AddTimestampToModerateTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :moderate_tasks, :created_at, :datetime, null: false
    add_column :moderate_tasks, :updated_at, :datetime, null: false
  end
end
