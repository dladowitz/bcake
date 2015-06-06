class LocationsController < ApplicationController
  layout "landing_page/landing_layout", only: [:index, :show, :signup]
  before_filter :url_rerouter, only: :show
  skip_before_filter :require_login, only: [:index, :show, :signup]

  def index
    @locations = Location.all
  end

  def show
    @location  = Location.find params[:id]
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    @location.user_id = current_user.id
    if @location.save
      flash[:success] = "Location Created Successfully!" #TODO pretty sure there is short hand to for this.
      render :user_location
    else
      render :new
    end
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

  # Not sure if user_locations and user_location should be their own controller.
  def user_locations
    @locations = current_user.locations
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

  def location_params
    params.require(:location).permit(:name, :img_url)
  end
end
