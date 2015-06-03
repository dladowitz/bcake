class LocationsController < ApplicationController
  def index
    @locations = Location.all
    render layout: "landing_page/landing_layout"
  end

  def show
    @location  = Location.find params[:id]
    render layout: "landing_page/landing_layout"
  end
end
