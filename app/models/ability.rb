class Ability
  include CanCan::Ability
  # TODO Get the fuck off of CanCan, it is such a pain to use

  # https://github.com/CanCanCommunity/cancancan

  # Usage:
  # There are two ways to authorize.
  # 1. add 'load_and_authorize_resource' at the top of the controller
  #      make sure to only try and authorize(here in ability.rb) the object that load_and_authorize_resource instantiates. Do not create an object yourself inside the action or ability won't have access to it in this file
  # 2. add 'authorize! :show, @location' to an action after the object has been defined
  #      you can then authorize agains the @location object here in ability.rb
  # cancan is calling current_user from the application controller and
  # passing the user object as an argument to #initialize.
  # #current_user and other ApplicationController methods are unavailable here.
  def initialize(current_user)
    # Define abilities for the passed in user here.
    current_user ||= User.new # guest user (not logged in)

    # admin can access everything
    if current_user.admin?
      can :manage, :all
    else
      # index, new, and create are open to everyone
      can [:index, :new, :create],  User
#
      # allow if current_user matches the user_record being viewed
      can [:show, :edit, :update], User do |user_record|
        current_user.id == user_record.id
      end

      # allow if the location belongs to the current_user
      can :user_location, Location do |location|
        current_user.locations.include?(location)
      end
    end
  end
end
