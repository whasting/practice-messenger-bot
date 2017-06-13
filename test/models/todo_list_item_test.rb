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

require 'test_helper'

class TodoListItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
