class AddUserToPools < ActiveRecord::Migration[5.1]
  def change
    add_reference :pools, :user, foreign_key: true
  end
end
