class AddUserColumnToWork < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :user_id, :string, foreign_key: true, index: true
  end
end
