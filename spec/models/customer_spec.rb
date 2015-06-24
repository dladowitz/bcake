require 'rails_helper'

describe Customer do
  # it { should validate_presence_of :birthday } # Doesn't work because we changed the validation message.
  it { should validate_presence_of :email }
  it { should have_and_belong_to_many :locations }
  it { should have_many :vouchers }

  it "has a valid factory" do
    customer = create :customer
    expect(customer).to be_a Customer
    expect(customer.email).to eq "russ@tradecraft.com"
  end

  it "has a custom validation message on birthday" do
    customer = Customer.new(email: "brett@tradecraft.com")
    customer.save
    expect(customer.errors[:birthday].first).to eq "is invalid"
  end

  describe "#add_location" do
    let(:customer) { create :customer }
    let(:location) { create :location }
    subject { customer.add_location location }

    context "when the customer hasn't signed up for the locaiton yet" do
      it "adds the location to the customer" do
        subject
        expect(customer.locations).to include location
      end

      it "returns true" do
        expect(subject).to eq customer.locations
      end

      skip "it creates a voucher for the customer" do
        subject
        expect(customer.vouchers).to eq 1
      end
    end

    context "when the customer has already signed up for the location" do
      before do
        customer.locations << location
      end

      it "does not add the location to the customer" do
        subject
        expect(customer.locations.count).to eq 1
      end

      it "returns false" do
        expect(subject).to eq false
      end
    end
  end
end
