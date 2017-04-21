class AddUserWorkForeignKeys < ActiveRecord::Migration[5.0]
  def change
    add_reference :works, :users, foreign_key: true
    add_reference :users, :works, foreign_key: true
  end
end
