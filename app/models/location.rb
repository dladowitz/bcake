# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  name       :string
#  img_url    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Location < ActiveRecord::Base
  validates :name, presence: true

  has_and_belongs_to_many :customers
  belongs_to :user

  #currently locations only have one deal.
  #This may need to change to has_many. Otherwise when a deal changes a user will get the new deal instead of the one emailed to them. 
  has_one :deal
end
