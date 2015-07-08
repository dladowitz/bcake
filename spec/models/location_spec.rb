require 'rails_helper'

describe Location do
  it { should validate_presence_of :name }
  it { should have_and_belong_to_many :customers }
  it { should belong_to :user }
  it { should have_one :deal }
  it { should have_many :vouchers }

  it "has a valid factory" do
    location = create :location, name: "Cafe Flora", img_url: "http://cafeflora.com"
    expect(location).to be_a Location
    expect(location.name).to eq "Cafe Flora"
  end

  describe "#customer_signups" do
    include ActiveSupport::Testing::TimeHelpers
    location = create :location
    customer1 = create :customer
    customer2 = create :customer

    # using TimeHelpers to travel in time
    before do
      location.customers << customer1
      travel -10.days
      location.customers << customer2
      travel_back
    end

    it "correctly counts the number of customers signed up in the time period " do
      expect(location.customer_signups(7.days.ago)).to eq 1
    end

    it "correctly counts the number of customers signed up in the time period " do
      expect(location.customer_signups(30.days.ago)).to eq 2
    end
  end
end
