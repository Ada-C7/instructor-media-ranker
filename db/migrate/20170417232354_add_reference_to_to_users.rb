class AddReferenceToToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :works, :user
  end
end
