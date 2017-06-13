# == Schema Information
#
# Table name: todo_lists
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TodoList < ApplicationRecord
  validates :user_id, null: false

  has_many :todo_list_items
  belongs_to :user

  before_save :default_name

  def default_name
    unless self.name
      todo_list_number = User.find(self.user_id).todo_lists.length + 1
      self.name ||= "Todo List ##{todo_list_number}"
    end
  end
end
