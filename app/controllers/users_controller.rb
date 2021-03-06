class UsersController < ApplicationController
  load_and_authorize_resource
  skip_before_action :require_login, only: [:new, :create]

  def index
    # @page_name = "Users"
    @users = User.all
  end

  def new
    @user = User.new

    render layout: "landing_page/landing_layout"
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = "Account created successfully. Lets get some more customers!"

      #TODO Mailer should be sent asyncronously. Need to change so not to hold up the controller
      UserMailer.signup_email(@user).deliver_now
      UserMailer.new_user_notice_email(@user).deliver_now

      session[:id] = @user.id
      redirect_to user_path(@user)
    else
      render :new, layout: "landing_page/landing_layout"
    end
  end

  def show
    @page_name = "Dashboard"

    if @user
      @location = @user.locations.first
      @deal = @location.deal if @location
      render :show
    else
      redirect_to root_path
    end
  end

  def edit
    @page_name = @user.first_name.capitalize
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = "Updated account"
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
  end
end
