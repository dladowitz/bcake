# == Schema Information
#
# Table name: customer_signups
#
#  customer_id :integer
#  location_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  id          :integer          not null, primary key
#
# Indexes
#
#  index_customer_signups_on_customer_id  (customer_id)
#  index_customer_signups_on_location_id  (location_id)
#

# This started out as a has_and_belongs_to_many, but was changed into a has_many :through.
# So the name is funny. Probably just need to rename it along with the database table.
# Not sure what other errors might creep up though.
class CustomerSignup < ActiveRecord::Base
  belongs_to :customer
  belongs_to :location
end
