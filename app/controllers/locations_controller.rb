class LocationsController < ApplicationController
  layout "landing_page/landing_layout"
  before_filter :url_rerouter, only: :show

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

  private

  def url_rerouter
    # Because we need to use a url shortener for locations
    # all routes must be prepended with /c/ to prevent locations#show from matching.
    # This is a workaround to all the urls to be used without /c/
    # This may be slowing down the entire system though. We should verify.
    # This doesn't work with resources that have :id's however. Like users/3

    # prepend '/c/' if the :id is not a number
    if params[:id].to_i == 0
      redirect_to "/c/#{params[:id]}"
    end
  end
end
