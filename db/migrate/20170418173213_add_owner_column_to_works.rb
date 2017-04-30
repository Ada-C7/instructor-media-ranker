class AddOwnerColumnToWorks < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :owner_id, :integer
  end
end
