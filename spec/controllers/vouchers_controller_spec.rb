require 'rails_helper'

describe VouchersController do
  describe 'GET show' do
    let(:voucher) { vouchers(:voucher1) }
    subject { get :show, token: voucher.token }

    before { subject }
    it "returns the voucher show template" do
      expect(response).to render_template :show
    end

    context "with a valid token" do
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
end
