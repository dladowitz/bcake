class VouchersController < ApplicationController
  layout "customer_pages/customer_layout"
  skip_before_action :require_login
  before_action :set_voucher

  def show
    unless @voucher
      render text: 'Sorry, token not found', content_type: 'text/plain', status: 404
    end
  end

  def redeem
    unless @voucher.redeemed
      @voucher.update_attributes(redeemed: Time.now)
    end
  end

  private

  def set_voucher
    @voucher = Voucher.find_by_token params[:token]
  end
end
