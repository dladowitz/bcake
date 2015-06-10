class DealsController < ApplicationController
  before_filter :set_location
  def new
    @deal = Deal.new
  end

  def create
    @deal = Deal.new(deal_params)
    if @deal.save
      flash[:success] = "Woot! Deal successfully created."
      redirect_to user_location_path(@location)
    else
      render :new
    end
  end

  private

  def set_location
    @location  = Location.find params[:location_id]
  end

  def deal_params
    params.require(:deal).permit(:birthday_deal, :monthly_deal)
  end
end
