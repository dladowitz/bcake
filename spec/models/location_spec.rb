require 'rails_helper'

describe Location do
  it { should validate_presence_of :name }

  it "has a valid factory" do
    location = create :location, name: "Cafe Flora", img_url: "http://cafeflora.com"
    expect(location).to be_a Location
    expect(location.name).to eq "Cafe Flora"
  end
end