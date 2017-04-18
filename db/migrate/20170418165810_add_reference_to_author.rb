class AddReferenceToAuthor < ActiveRecord::Migration[5.0]
  def change
    remove_column :works, :user_id
    add_reference :works, :user, foreign_key: true
  end
end
