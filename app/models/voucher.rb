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
#  sent        :datetime
#

class Voucher < ActiveRecord::Base
  validates :location_id, :customer_id, presence: true
  validates :token, presence: true
  validates :token, uniqueness: true

  belongs_to :location
  belongs_to :customer

  before_validation :set_token, if: :new_record?

  EXPIRATION_PERIOD = 30.days
  REDEMPTION_PERIOD = 24.hours

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

  # TODO write spec
  # will only set redemtion the first time.
  def set_as_redeemed
    if self.customer.demo_account || !self.redeemed
      self.update_attributes(redeemed: Time.now)
    end
  end

  # The loop keeps running if the token already exists
  def set_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Voucher.exists?(token: random_token)
    end
  end
end
