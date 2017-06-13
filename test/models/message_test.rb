# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  messages     :text             default("{}"), is an Array
#  last_message :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
