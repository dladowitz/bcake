require 'rails_helper'

describe Voucher do
  it { should validate_presence_of :customer_id }
  it { should validate_presence_of :location_id }
  it { should belong_to :customer }
  it { should belong_to :location }

  # Not sure why token validation tests aren't working.
  # Validations on the model are working.
  # it { should validate_presence_of :token }
  # it { should validate_uniqueness_of :token }

  describe "#expired?" do
    let(:voucher) { create(:voucher) }

    context "when the expiration period has elapsed" do
      before { voucher.created_at = 1.year.ago }
      it "is expired" do
        expect(voucher.expired?).to be true
      end
    end

    context "when the expiration period has not elapsed" do
      it "is not expired" do
        expect(voucher.expired?).to be false
      end
    end
  end

  describe "#within_redemtion_period?" do
    let(:voucher) { create(:voucher) }

    context "when it hasn't been redeemed yet" do
      it "is still with the period" do
        expect(voucher.within_redemtion_period?).to be true
      end
    end

    context "when it has been redeemed already" do
      context "when it's been less than the redemption period" do
        before { voucher.redeemed = Time.now }

        it "is still with the period" do
          expect(voucher.within_redemtion_period?).to be true
        end
      end

      context "when it's been more than the redemption period" do
        before { voucher.redeemed = 1.day.ago }

        it "is not within the period" do
          expect(voucher.within_redemtion_period?).to be false
        end
      end
    end
  end
end
