class CreateTodoLists < ActiveRecord::Migration[5.0]
  def change
    create_table :todo_lists do |t|
      t.bigint :user_id, null: false
      t.string :name

      t.timestamps
    end
    add_index :todo_lists, :user_id
  end
end
