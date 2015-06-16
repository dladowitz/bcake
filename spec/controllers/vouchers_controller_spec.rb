require 'rails_helper'

describe VouchersController do
  describe 'GET show' do
    let(:voucher) { vouchers(:voucher1) }
    subject { get :show, token: voucher.token }

    context "with a valid token" do
      before { subject }

      context "when the voucher has not been redeemed yet" do
        it "returns the voucher show template" do
          expect(response).to render_template :show
        end

        it "finds a voucher in the database" do
          expect(assigns(:voucher)).to eq voucher
        end
      end

      context "when the voucher has already been redeemed" do
        context "when the redemtion period has not elasped" do
          before { voucher.update_attributes(redeemed: 2.hours.ago) }
          subject { get :show, token: voucher.token }
          it "does not change the redemtion time" do
            expect{ subject }.not_to change{ voucher.reload.redeemed }
          end

          it "renders the show template" do
            subject
            expect(response).to render_template :show
          end
        end

        context "when the redemtion period has already elapsed" do
          before { voucher.update_attributes(redeemed: 4.days.ago) }

          it "renders the no_good template" do
            # Running subject in the spec. Problem with ordering
            get :show, token: voucher.token
            expect(response).to render_template :no_good
          end
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
        context "when the redemtion period has not elasped" do
          before { voucher.update_attributes(redeemed: 1.hour.ago) }

          it "does not change the redemtion time" do
            expect{ subject }.not_to change{ voucher.reload.redeemed }
          end

          it "renders the redeem template" do
            subject
            expect(response).to render_template :good
          end
        end

        context "when the redemtion period has already elapsed" do
          before { voucher.update_attributes(redeemed: 4.days.ago) }

          it "renders the no_good template" do
            subject
            expect(response).to render_template :no_good
          end
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
