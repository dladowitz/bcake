class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # most features require a user to be logged on.
  before_filter :require_login

  before_filter :set_current_user_on_user_model

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      flash[:danger] = "You are not authorized for this page. All your bases are belong to us."
      puts "---------- You are not authorized for this page. All your bases are belong to us. ----------" unless Rails.env == "test"
      redirect_to user_path(current_user)
    else
      flash[:danger] = "You must be logged for this page. All your bases are belong to us."
      puts "---------- You must be logged for this page. All your bases are belong to us. ----------" unless Rails.env == "test"

      redirect_to root_path
    end

  end

  # TODO need to suppress puts statements in specs
  # http://stackoverflow.com/questions/15430551/suppress-console-output-during-rspec-tests

  rescue_from ActiveRecord::RecordNotFound do |exception|
    flash[:danger] = "That's not a thing in the database"
    puts "---------- That's not a thing in the database ----------" unless Rails.env == "test"
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

  private

  def set_current_user_on_user_model
    # Used so current_user is available on the User model. Specifically for updating admin accounts.
    # Maybe not the best way to do this. See User model
    # http://clearcove.ca/2008/08/recipe-make-request-environment-available-to-models-in-rails/
    User.current_user = current_user
  end
end
