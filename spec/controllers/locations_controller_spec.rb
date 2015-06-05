require 'rails_helper'

describe LocationsController do
  describe 'GET index' do
    subject { get :index }
    before { subject }

    it 'returns the index template' do
      expect(response).to render_template :index
    end

    it 'returns a list' do
      expect(assigns(:locations).count).to eq Location.all.count
    end

    it 'has location objects in the list' do
      expect(assigns(:locations).first).to be_a Location
    end
  end

  describe 'Get show' do
    let (:location) { create :location, name: "tradecraft" }
    subject { get :show, {id: location.id} }
    before { subject }

    it 'returns the show template' do
      expect(response).to render_template :show
    end
  end

  describe 'POST signup' do
    let (:location) { create :location, name: "tradecraft" }
    subject { post :signup, {id: location.id, email: "janardin@tradecraft.com", birthday: "1981-07-04"}}

    it "adds a location to the customer" do
      subject
      expect(assigns(:customer).locations).to include location
    end

    context "when there are no customers with the email address already" do
      it "creates a new customer in the database" do
        expect{ subject }.to change{ Customer.count }.by 1
      end
    end

    context "when there already is a customer with the email address" do
      before { create :customer, email: "janardin@tradecraft.com" }

      it "does not create a new customer in the database" do
        expect{ subject }.not_to change{ Customer.count}
      end
    end
  end


  describe 'GET user_locations' do
    subject { get :user_locations }

    context 'when logged in as a user' do

      before do
        @user = users(:owner)
        login_user @user
        subject
      end

      it 'returns the user_locations template' do
        expect(response).to render_template :user_locations
      end

      it 'finds all the users locations' do
        expect(assigns[:locations]).to eq @user.locations
      end
    end

    context 'when not logged in' do
      before { subject }

      it "renders the home page" do
        expect(response).to redirect_to root_path
      end

      it "displays an error message" do
        expect(flash[:danger]).to eq "You must be logged in to do that."
      end
    end
  end
end
