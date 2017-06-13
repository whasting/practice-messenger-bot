class CreateTodoListItems < ActiveRecord::Migration[5.0]
  def change
    create_table :todo_list_items do |t|
      t.integer :todo_list_id, null: false
      t.text :body, null: false

      t.timestamps
    end
    add_index :todo_list_items, :todo_list_id
  end
end
