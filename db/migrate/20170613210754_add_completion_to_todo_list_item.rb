class AddCompletionToTodoListItem < ActiveRecord::Migration[5.0]
  def change
    add_column :todo_list_items, :complete, :boolean, default: false
  end
end
