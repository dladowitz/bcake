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
    render :signup_confirmation
  end
end
