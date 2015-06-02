require 'rails_helper'

describe LocationsController do
  describe 'GET index' do
    subject { get :index }

    before do
      create :location
      subject
    end

    it 'returns the index template' do
      expect(response).to render_template :index
    end

    it 'returns a list' do
      expect(assigns(:locations)).to be_a Array
    end

    it 'has location objects in the list' do
      expect(assigns(:locations).first)to be_a Location
    end
  end
end
