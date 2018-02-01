class AddSampleToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :samp, :boolean, null: false, default: false
  end
end
