# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  name       :string
#  img_url    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ActiveRecord::Base
  validates :name, presence: true

  has_and_belongs_to_many :customers
end
