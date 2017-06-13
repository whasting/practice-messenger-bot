class ChangeUserId < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :facebook_id
    change_column :users, :id, :bigint, null: false, unique: true
  end
end
