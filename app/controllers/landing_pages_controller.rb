class LandingPagesController < ApplicationController
  skip_before_filter :require_login
  layout "landing_page/landing_layout"

  def landing

  end

  def contact
    CustomerMailer.contact_email(params[:contact]).deliver_now

    flash[:success] = "Great, well be in touch shortly."
    render :contact_confirmation
  end
end
