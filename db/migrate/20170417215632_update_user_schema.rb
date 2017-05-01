class UpdateUserSchema < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :username
    add_column :users, :name, :string
    add_column :users, :email, :string, null: false
    add_column :users, :uid, :integer, null: false
    add_column :users, :provider, :integer, null: false
  end
end
