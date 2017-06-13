require 'rails_helper'

RSpec.describe TodoListItem, type: :model do
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:todo_list_id) }
  it { should belong_to(:todo_list) }
end
