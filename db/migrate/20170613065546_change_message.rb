class ChangeMessage < ActiveRecord::Migration[5.0]
  def change
    change_column :messages, :user_id, :bigint
  end
end
