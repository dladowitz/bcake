require "rails_helper"

describe Deal do
  it { should validate_presence_of :birthday_deal }
  it { should validate_presence_of :monthly_deal }
  it { should belong_to :location }

  it "has a valid factory" do
    deal = create :deal
    expect(deal).to be_a Deal
    expect(deal.birthday_deal).to eq "Free Panini"
  end
end
