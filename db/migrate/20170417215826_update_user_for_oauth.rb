class UpdateUserForOauth < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string :name
      t.integer :uid, null: false
      t.string :provider, null: false
      t.rename :email, :email
    end

    change_column_null :users, :email, false
  end
end
