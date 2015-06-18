class LocationsController < ApplicationController
  layout "customer_pages/customer_layout", only: [:index, :show, :signup]
  skip_before_action :require_login, only: [:index, :show, :signup]
  # TODO create before_filter :set_location

  def index
    @locations = Location.all
  end

  def show
    @location  = Location.find params[:id]
    @deal = @location.deal
    @customer = Customer.new
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


  # This action is getting kinda hectic
  def signup
    # TODO create a method to intelligently pull nearby locations
    @locations = Location.all.limit 5
    @location = Location.find params[:id]

    # if customer is already in db find them, otherwise create a new record
    @customer  = Customer.find_or_create_by(email: params[:customer][:email]) do |customer|
      begin
        customer.birthday = Date.strptime(params[:customer][:birthday], '%m-%d-%Y') #converts month/day/year to day/month/year
      rescue ArgumentError => e
        #  should surface invalid date to the view somehow
        # raise e
      end
    end

    if @customer.save
      if @customer.add_location(@location)
        render :signup_confirmation
      else
        render :signup_error
      end
    else
      @deal = @location.deal
      render :show and return
    end
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
