require 'rails_helper'

describe DealsController do
  let(:location) { locations(:jackson) }

  describe "GET new" do
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
        let(:user2) { users(:owner2) }

        before do
          login_user user2
          subject
        end

        skip "redirects to the user_path" do
          expect(response).to redirect_to user_path(user2)
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

  describe "POST create" do
    subject { post :create, { location_id: location.id, deal: {birthday_deal: "Free Burger", monthly_deal: "Free Coffee" } } }

    context "with a logged in user" do
      context "when the user has permissions for the location" do
        let(:user) { users(:owner) }
        before { login_user user }

        it "creates a new deal in the database" do
          expect{ subject }.to change{ Deal.count }.by 1
        end

        it "displays a flash[:message]" do
          subject
          expect(flash[:success]).to eq "Woot! Deal successfully created."
        end
      end

      context "when the user does not have permissions for the location" do
        before { login_user user2 }
        let(:user2) { users(:owner2) }

        skip "does not create a new deal in the database" do
          expect{ subject }.not_to change{ Deal.count }
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
