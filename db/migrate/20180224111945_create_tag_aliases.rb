class CreateTagAliases < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_aliases do |t|
      t.integer :tag_id
      t.integer :alias_id

      t.timestamps
    end
  end
end
