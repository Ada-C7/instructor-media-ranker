class RenameUsersIdCol < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :works_id, :work_id
    rename_column :works, :users_id, :user_id
  end
end
