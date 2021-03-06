FixtureBuilder.configure do |fbuilder|
  # rebuild fixtures automatically when these files change:
  fbuilder.files_to_check += Dir["spec/factories/*.rb", "spec/support/fixture_builder.rb"]

  # Include Factory Girl syntax to simplify syntax from: FactoryGirl.create(:category, name: "Comedy")) to: create(:category, name: "Comedy"))
  include FactoryGirl::Syntax::Methods

  # now declare objects
  fbuilder.factory do

    # users
    @admin     = create(:user, first_name: "David",    last_name: "Ladowitz", email: "david@tradecraft.com",  admin: true )
    @owner     = create(:user, first_name: "Brandon",  last_name: "David",    email: "brandon@tradecraft.com", admin: false )
    @owner2    = create(:user, first_name: "Justin",   last_name: "Smith",    email: "justing@tradecraft.com", admin: false )

    # locations owned by @owner1
    @jackson = create(:location, name: "Jackson Place Cafe", user_id: @owner.id, img_url: "http://www.fillmurray.com/500/300")
    @yoyos   = create(:location, name: "Yo Yo's",            user_id: @owner.id, img_url: "http://www.fillmurray.com/500/300")
    @brioche = create(:location, name: "Brioche Bakery",     user_id: @owner.id, img_url: "http://www.fillmurray.com/500/300")
    @flora   = create(:location, name: "Cafe Flora",         user_id: @owner.id, img_url: "http://www.fillmurray.com/500/300")

    # deals
    @deal1 = create(:deal, location_id: @jackson.id, birthday_deal: "Free Panini", monthly_deal: "Free Coffee")

    # customer signed up for a location
    # @customer1 = create(:customer, email: "amy@tradecrafted.com", birthday: "2001-10-25")
    # @customer1.locations << @jackson

    #vouchers
    @voucher1 = create(:voucher, location: @jackson)

  end
end


# https://github.com/rdy/fixture_builder

# Examples:

# # users
# @james_bond  = create(:user, full_name: "James Bond",       email_address: "james@007.com" )
# @dr_evil     = create(:user, full_name: "Dr Evil",          email_address: "dr@evil.com")

# Not sure the difference between @james_bond and james_bond.
# They seem to become named instances in the yml file, but not in a consistancy I can see

# # categories
# comedy  = create(:category, name: "Comedy")
# action  = create(:category, name: "Action")

# # videos
# iron_man   =               create(:video, title: "Iron Man",   category: action, created_at: Time.now - 7.hour)
# fbuilder.name(:iron_man_4, create(:video, title: "Iron Man 4", category: action, created_at: Time.now - 4.hour))

# # reviews
# fbuilder.name(:iron_man_review_1, create(:review, video: iron_man, user: @james_bond, rating: 5))
# fbuilder.name(:iron_man_review_2, create(:review, video: iron_man, user: @dr_evil,    rating: 4))

# # queue_items
# fbuilder.name(:james_bonds_first_qi,  create(:queue_item, user: @james_bond, video: iron_man,   queue_rank: 1))

# # relationships
# create(:relationship, followed_user: @fat_bastard, follower: @james_bond)

# --

# fbuilder.name(:davids_ipod, Factory(:purchase, :user => david, :product => ipod))
# @davids_ipod = Factory(:purchase, :user => david, :product => ipod)


# fbuilder.name_model_with(User) do |record|
#   [record['first_name'], record['last_name']].join('_')
# end
