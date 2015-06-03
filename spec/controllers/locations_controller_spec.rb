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
    subject { post :signup, {id: location.id, customer: {email: "janardin@tradecraft.com", birthday: "1981-0704"}}}
    
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
      it "does not create a new customer in the database" do
        expect{ subject }.not_to change{ Customer.count}
      end
    end
  end
end
