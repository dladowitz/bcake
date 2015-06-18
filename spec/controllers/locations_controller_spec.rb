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

  describe 'GET new' do
    subject { get :new }

    context 'with a logged in user' do
      let(:user) { users(:owner) }

      before do
        login_user user
        subject
      end

      it 'returns the new template' do
        expect(response).to render_template :new
      end

      it 'instantiates a location object' do
        expect(assigns[:location]).to be_a Location
      end
    end

    context 'without a logging in user' do
      before { subject }

      it 'redirects to the root page' do
        expect(response).to redirect_to root_path
      end

      it 'displays a flash message' do
        expect(flash[:danger]).to eq "You must be logged in to do that."
      end
    end
  end

  describe 'POST create' do
    subject { post :create, location: { name: "Ramen Underground", img_url: "http://foodinline.com/images/vendor/8731/home/m-ramenunderground.jpg"}}

    context "with a logged in user" do
      let(:user) { users(:owner) }
      before { login_user user }

      it "creates a new location in the database" do
        expect{ subject }.to change{ Location.count }.by 1
      end

      it "renders the :user_location template" do
        subject
        expect(response).to render_template :user_location
      end

      it "adds the location to the user" do
        subject
        expect(user.reload.locations.last.name).to eq "Ramen Underground"
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

  describe 'GET show' do
    let (:location) { create :location, name: "tradecraft" }
    subject { get :show, {id: location.id} }
    before { subject }

    it 'returns the show template' do
      expect(response).to render_template :show
    end
  end

  describe 'POST signup' do
    let (:location) { create :location, name: "tradecraft" }
    subject { post :signup, {id: location.id, customer: { email: "janardin@tradecraft.com", birthday: "11-07-80"}}}

    context "when there are no customers with the email address already" do
      it "creates a new customer in the database" do
        expect{ subject }.to change{ Customer.count }.by 1
      end

      it "adds a location to the customer" do
        subject
        expect(assigns(:customer).locations).to include location
      end

    end

    context "when there already is a customer with the email address" do
      before { create :customer, email: "janardin@tradecraft.com" }

      context "when the customer has NOT already signed up for the location" do
        it "does not create a new customer in the database" do
          expect{ subject }.not_to change{ Customer.count}
        end

        it "adds a location to the customer" do
          subject
          expect(assigns(:customer).locations).to include location
        end
      end

      context "when the customer HAS already signed up for the location" do
        before { post :signup, {id: location.id, customer: { email: "janardin@tradecraft.com", birthday: "11-07-80"}}}

        it "does not add the location to the customer" do
          expect(assigns(:customer).locations.count).to eq 1
        end

        it "renders signup_error template" do
          subject
          expect(response).to render_template :signup_error
        end
      end
    end
  end

  describe 'GET user_locations' do
    subject { get :user_locations }

    context 'when logged in as a user' do
      let(:user) { users(:owner) }

      before do
        login_user user
        subject
      end

      it 'returns the user_locations template' do
        expect(response).to render_template :user_locations
      end

      it 'finds all the users locations' do
        expect(assigns[:locations]).to eq user.locations
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

  describe 'GET user_location' do
    let(:user)     { users(:owner)}
    let(:user2)    { users(:owner2)}
    let(:location) { user.locations.first}
    subject { get :user_location, id: location.id}

      context 'when the location belongs to the user' do
        context 'with a logged in user' do
          before do
            login_user user
            subject
          end

        it 'renders the user_location template' do
          expect(response).to render_template :user_location
        end

        it 'finds the correct location' do
          expect(assigns(:location)).to eq location
        end
      end

      context 'when the location does not belong to the user' do
        before do
          login_user user2
          subject
        end

        it 'redirect_to the user_locations' do
          expect(response).to redirect_to user_path(user2)
        end

        it 'it displays a flash danger message' do
          expect(flash[:danger]).to eq "You are not authorized for this page. All your bases are belong to us."
        end
      end
    end

    context 'without a logged in user' do
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
