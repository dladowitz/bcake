class VouchersController < ApplicationController
  layout "customer_pages/customer_layout"
  skip_before_action :require_login
  before_action :set_voucher

  # Probably should refactor. Double nesting doesn't look so good.
  # Also show and redeem look pretty similiar
  def show
    if @voucher.redeemed
      if @voucher.within_redemtion_period?
        @voucher.set_as_redeemed
        @redemtion_expiration = @voucher.redeemed + Voucher::REDEMPTION_PERIOD
        render :good
      else
        render :no_good
      end
    else
      render :show
    end
  end

  def redeem
    if @voucher.within_redemtion_period?
      @voucher.set_as_redeemed
      @redemtion_expiration = @voucher.redeemed + Voucher::REDEMPTION_PERIOD
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
