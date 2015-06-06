class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # most features require a user to be logged on.
  before_filter :require_login

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      flash[:danger] = "You are not authorized for this page. All your bases are belong to us."
      puts "---------- You are not authorized for this page. All your bases are belong to us. ----------"
      redirect_to user_path(current_user)
    else
      flash[:danger] = "You must be logged for this page. All your bases are belong to us."
      puts "---------- You must be logged for this page. All your bases are belong to us. ----------"

      redirect_to root_path
    end

  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    flash[:danger] = "That's not a thing in the database"
    puts "---------- That's not a thing in the database ----------"
    redirect_to root_path
  end

  def current_user
    User.find session[:id] if session[:id]
  end
  helper_method :current_user  #makes available in view

  def require_login
    unless current_user
      flash[:danger] = "You must be logged in to do that."
      redirect_to root_path and return
    end
  end
end
