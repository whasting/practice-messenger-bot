require 'rails_helper'

RSpec.describe TodoList, type: :model do
  subject(:todo_list) do
    todo_list = TodoList.new(user_id: 123)
  end

  it { should validate_presence_of(:user_id) }
  it { should have_many(:todo_list_items) }
  it { should belong_to(:user) }

  describe "#default_name "
    it "sets the name to a default value if no name is given" do
      # TODO: Need to properly setup default_name method
    end
end
