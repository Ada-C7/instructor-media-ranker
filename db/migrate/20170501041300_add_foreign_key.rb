class AddForeignKey < ActiveRecord::Migration[5.0]
  def change
    add_reference :works, :user, index: true
    add_foreign_key :works, :users
  end
end
