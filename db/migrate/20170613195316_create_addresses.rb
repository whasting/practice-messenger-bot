class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.text :full_address, null: false
      t.bigint :user_id, null: false

      t.timestamps
    end
    add_index :addresses, :user_id
  end
end
