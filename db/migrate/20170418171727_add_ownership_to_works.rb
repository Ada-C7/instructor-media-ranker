class AddOwnershipToWorks < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :belongs_to, :integer
  end
end
