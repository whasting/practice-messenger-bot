class ChangeUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :username
    add_column :users, :username, :string
    add_column :users, :facebook_id, :bigint, null: false
  end
end
