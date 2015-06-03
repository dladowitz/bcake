require 'rails_helper'

describe Customer do
  it { should validate_presence_of :email }
  it { should validate_presence_of :birthday }
  it { should have_and_belong_to_many :locations }

  it "has a valid factory" do
    customer = create :customer
    expect(customer).to be_a Customer
    expect(customer.email).to eq "russ@tradecraft.com"
  end
end
