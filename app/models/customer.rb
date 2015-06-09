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
  validates :email, :birthday, presence: true

  has_and_belongs_to_many :locations

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
