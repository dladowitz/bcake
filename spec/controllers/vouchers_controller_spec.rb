require 'rails_helper'

describe VouchersController do
  describe 'GET show' do
    let(:voucher) { vouchers(:voucher1) }
    subject { get :show, token: voucher.token }

    context "with a valid token" do
      before { subject }

      it "returns the voucher show template" do
        expect(response).to render_template :show
      end

      it "finds a voucher in the database" do
        expect(assigns(:voucher)).to eq voucher
      end
    end

    context "with an invalid token" do
      subject { get :show, token: "Fake Token" }

      it "does not find a voucher in the database" do
        expect(assigns(:voucher)).to be_nil
      end
    end
  end

  describe 'GET redeem' do
    let(:voucher) { vouchers(:voucher1) }
    subject { get :redeem, token: voucher.token }

    context "with a valid token" do
      it "finds a voucher in the database" do
        subject
        expect(assigns(:voucher)).to eq voucher
      end

      context "when the voucher hasn't been redeemed yet" do
        it "sets the voucher as redeemed" do
          expect{ subject }.to change{ voucher.reload.redeemed }.to be_truthy
        end
      end

      context "when the voucher has already been redeemed" do
        before { voucher.update_attributes(redeemed: 1.hour.ago) }

        it "does not change the redemtion time" do
          expect{ subject }.not_to change{ voucher.reload.redeemed }
        end
      end
    end

    context "with an invalid token" do
      subject { get :show, token: "Fake Token" }

      it "does not find a voucher in the database" do
        expect(assigns(:voucher)).to be_nil
      end
    end
  end
end
