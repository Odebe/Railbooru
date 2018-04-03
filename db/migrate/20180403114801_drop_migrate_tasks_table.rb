class DropMigrateTasksTable < ActiveRecord::Migration[5.1]
  def up
    drop_table :moderate_tasks
  end
  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
