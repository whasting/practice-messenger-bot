# == Schema Information
#
# Table name: todo_list_items
#
#  id           :integer          not null, primary key
#  todo_list_id :integer          not null
#  body         :text             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class TodoListItem < ApplicationRecord
  validates :todo_list_id, :body, presence: true

  belongs_to :todo_list
end
