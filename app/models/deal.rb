# == Schema Information
#
# Table name: deals
#
#  id            :integer          not null, primary key
#  birthday_deal :string
#  monthly_deal  :string
#  location_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Deal < ActiveRecord::Base
  belongs_to :location
  validates :birthday_deal, :monthly_deal, presence: true
end
