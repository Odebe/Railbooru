class AddStatusToModerationTasksTable < ActiveRecord::Migration[5.1]
  def change
    add_column :moderate_tasks, :status, :integer, default: 0
  end
end
