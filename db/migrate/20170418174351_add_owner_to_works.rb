class AddOwnerToWorks < ActiveRecord::Migration[5.0]
  def change
    add_reference :works, :user, foriegn_key: true
  end
end
