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
end
