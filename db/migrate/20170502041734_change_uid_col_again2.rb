class ChangeUidColAgain2 < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :uid, :string, null: false
  end
end
