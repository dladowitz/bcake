# == Schema Information
#
# Table name: vouchers
#
#  id          :integer          not null, primary key
#  token       :string
#  customer_id :integer
#  location_id :integer
#  redeemed    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Voucher < ActiveRecord::Base
  validates :location_id, :customer_id, :token, presence: true
  validates :token, uniqueness: true

  belongs_to :location
  belongs_to :customer

  EXPIRATION_PERIOD = 30.days
  REDEMPTION_PERIOD = 12.hours

  def expired?
    (Time.now - created_at) >  EXPIRATION_PERIOD
  end

  def within_redemtion_period?
    if redeemed
      REDEMPTION_PERIOD > (Time.now - redeemed)
    else
      true
    end
  end
end
