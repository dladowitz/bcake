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
    let { create: location, name: "tradecraft" }
    subject { get :show, {id: location.id} }

    it 'returns the show template' do
      expect(response).to render_template :show
    end
  end
end