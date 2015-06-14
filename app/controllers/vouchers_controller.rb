class VouchersController < ApplicationController
  layout "customer_pages/customer_layout"
  skip_before_action :require_login
  before_action :set_voucher

  def show

  end

  private

  def set_voucher
    @voucher = Voucher.find_by_token params[:token]
  end
end
