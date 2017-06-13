class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :user_id, null: false
      t.text :messages, array: true, default: []
      t.text :last_message

      t.timestamps
    end
    add_index :messages, :user_id, unique: true
  end
end
