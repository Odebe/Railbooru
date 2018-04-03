class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :moderate_tasks, :type, :task_type
  end
end
