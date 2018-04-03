class DropModerateTasks < ActiveRecord::Migration[5.1]
  def change
    drop_table :moderate_tasks
  end
end
