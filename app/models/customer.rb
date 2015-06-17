# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  email      :string
#  birthday   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Customer < ActiveRecord::Base
  validates :email, presence: true
  validates_presence_of :birthday, :message => "is invalid"

  has_and_belongs_to_many :locations
  has_many :vouchers

  def add_location(location)
    if self.locations.include?(location)
      return false
    else
      self.locations << location
      # TODO send asyncronously
      CustomerMailer.location_signup_email(self, location).deliver_now
      return locations
    end
  end
end
