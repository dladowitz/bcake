class DealsController < ApplicationController
  before_filter :set_location
  before_filter :set_deal, only: [:edit, :update]

  def new
    @deal = Deal.new
  end

  def create
    #creating a has_one object has different syntax than has_many: http://stackoverflow.com/questions/2472982/using-build-with-a-has-one-association-in-rails
    @deal = @location.build_deal(deal_params)

    if @deal.save
      flash[:success] = "Woot! Deal successfully created."
      redirect_to user_location_path(@location)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @deal.update(deal_params)
      redirect_to user_location_path(@location)
    else
      render :edit
    end
  end

  private

  def set_location
    @location  = Location.find params[:location_id]
  end

  def set_deal
    @deal = Deal.find params[:id]
  end

  def deal_params
    params.require(:deal).permit(:birthday_deal, :monthly_deal)
  end
end
