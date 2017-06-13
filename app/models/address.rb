# == Schema Information
#
# Table name: addresses
#
#  id           :integer          not null, primary key
#  full_address :text             not null
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Address < ApplicationRecord
  validates :full_address, :user_id, presence: true
  belongs_to :user
end
