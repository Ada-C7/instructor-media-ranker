class AddOwner < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :owner, :int
  end
end
