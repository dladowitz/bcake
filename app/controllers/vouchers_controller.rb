class VouchersController < ApplicationController
  layout "customer_pages/customer_layout"
  skip_before_action :require_login
  before_action :set_voucher

  # Both show and redeem are pretty similiar. Maybe DRY them up
  def show
    if @voucher.within_redemtion_period?
      @voucher.set_as_redeemed
      render :show
    else
      render :no_good
    end
  end

  def redeem
    if @voucher.within_redemtion_period?
      @voucher.set_as_redeemed
      render :good
    else
      render :no_good
    end
  end

  private

  def set_voucher
    @voucher = Voucher.find_by_token params[:token]

    unless @voucher
      render text: 'Sorry, token not found', content_type: 'text/plain', status: 404
    end
  end
end
