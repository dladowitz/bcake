class LocationsController < ApplicationController
  layout "customer_pages/customer_layout", only: [:index, :show, :signup]
  skip_before_filter :require_login, only: [:index, :show, :signup]
  # TODO create before_filter :set_location

  def index
    @locations = Location.all
  end

  def show
    @location  = Location.find params[:id]
    @deal = @location.deal
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    @location.user_id = current_user.id
    if @location.save
      flash[:success] = "Nice. Location Created Successfully." #TODO pretty sure there is short hand to for this.
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
    @customer.add_location(@location) ? (render :signup_confirmation) : (render :signup_error)
  end

  # Not sure if user_locations and user_location should be their own controller.
  def user_locations
    @locations = current_user.locations
  end

  def user_location
    @location = Location.find params[:id]
    @deal = @location.deal
    authorize! :user_location, @location
  end

  private

  def location_params
    params.require(:location).permit(:name, :img_url)
  end
end
