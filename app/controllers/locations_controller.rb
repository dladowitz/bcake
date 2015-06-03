class LocationsController < ApplicationController
  def index
    @locations = Location.all
    render layout: "landing_page/landing_layout"
  end

  def show
    @location  = Location.find params[:id]
    @customer  = Customer.new
    render layout: "landing_page/landing_layout"
  end

  def signup
    @location = Location.find params[:id]

    # if customer is already in db find them, otherwise create a new record
    @customer  = Customer.find_or_create_by(email: params[:customer][:email]) do |customer|
      customer.birthday = params[:customer][:birthday]
    end

    # add location to customer
    @customer.locations << @location
    @customer.save

    render :signup_confirmation
  end
end
