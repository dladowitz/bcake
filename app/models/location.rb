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
#  short_name :string
#  active     :boolean
#
# Indexes
#
#  index_locations_on_short_name  (short_name)
#

class Location < ActiveRecord::Base
  validates :name, presence: true

  # This should really be a has_many :through
  has_many :customers, through: :customer_signups
  has_many :customer_signups
  belongs_to :user
  has_many :vouchers

  #currently locations only have one deal.
  #This may need to change to has_many. Otherwise when a deal changes a user will get the new deal instead of the one emailed to them.
  has_one :deal

  def customer_signups_in_past(time_frame = 10.years)
    CustomerSignup.where("created_at > ? AND location_id = ?", time_frame.ago, self.id).count
  end

  # TODO add tests for this method
  def deals_redeemed_in_past(time_frame = 10.years)
    self.vouchers.where("redeemed > ?", time_frame.ago).count
  end
end
