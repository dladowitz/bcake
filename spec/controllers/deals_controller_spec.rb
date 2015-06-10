require 'rails_helper'

describe DealsController do
  describe "GET new" do
    let(:location) { locations(:jackson) }
    subject { get :new, location_id: location.id }

    context "with a logged in user" do
      let(:user) { users(:owner) }

      before do
        login_user user
        subject
      end

      it 'returns the new template' do
        expect(response).to render_template :new
      end

      it 'instantiates a deal object' do
        expect(assigns[:deal]).to be_a Deal
      end

      context "when the user doesn't have permisions for the location" do
        skip "it redirects to the user_path" do
          expect(response).to redirect_to user_path(user)
        end
      end
    end

    context "without a logged in user" do
      before { subject }
      # TODO DRY this up with an 'it behaves like' thing. It should be used all over the place.
      it "redirects to the root page" do
        expect(response).to redirect_to root_path
      end

      it "shows a flash message" do
        expect(flash[:danger]).to eq "You must be logged in to do that."
      end
    end
  end
end
