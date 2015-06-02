class LocationsController < ApplicationController
  def index
    @locations = Location.all
    render layout: "landing_page/landing_layout"
  end
end
