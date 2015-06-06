class LandingPagesController < ApplicationController
  skip_before_filter :require_login

  def landing
    render layout: "landing_page/landing_layout"
  end
end
