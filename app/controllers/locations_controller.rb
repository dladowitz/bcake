class LocationsController < ApplicationController
  layout "landing_page/landing_layout"

  def index
    @locations = Location.all
  end

  def show
    @location  = Location.find params[:id]
  end

  def signup
    # TODO create a method to intelligently pull nearby locations
    @locations = Location.all.limit 5
    @location = Location.find params[:id]

    # if customer is already in db find them, otherwise create a new record
    @customer  = Customer.find_or_create_by(email: params[:email]) do |customer|
      customer.birthday = params[:birthday]
    end

    # add location to customer
    @customer.locations << @location
    @customer.save

    render :signup_confirmation
  end
end
