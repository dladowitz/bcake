# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
    users = User.create [{first_name: "David", last_name: "Ladowitz", email: "david@ladowitz.com", admin: true, password: "asdfasdf"},
                         {first_name: "Teresa", last_name: "Huang", email: "teresa@gmail.com", admin: true, password: "asdfasdf"}
                        ]

    locations = Location.create [{name: "Jackson Place Cafe", img_url: "http://s3-media2.fl.yelpcdn.com/bphoto/wnzCFQmFCelHRvtMDSBQuQ/l.jpg"},
                                 {name: "YoYo's", img_url: "http://s3-media1.fl.yelpcdn.com/bphoto/2rvvRVjBH6HFKq2OihuB0g/l.jpg"},
                                 {name: "Tradecraft", img_url: "http://s3-media2.fl.yelpcdn.com/bphoto/ISimnz4_yTvuPaa-aOwDMA/l.jpg"},
                                 {name: "Grumpys Pub", img_url: "http://s3-media1.fl.yelpcdn.com/bphoto/qb6rta1fa41Zif2Ni_Relw/l.jpg"},
                                 {name: "Cafe Me", img_url: "http://tripwhat.com/img/travel/item:-9223372036852286085:photos/8daa4557f8438379735fe1de5c12bd33-450-190"},
                                 {name: "Reveille Coffee", img_url: "http://s3-media4.fl.yelpcdn.com/bphoto/hVRz34RKipOGxAj2KH3Aww/l.jpg"},
                                 {name: "Brioche Bakery", img_url: "http://s3-media1.fl.yelpcdn.com/bphoto/CPo8fHYCkiCgtf5YAAxREQ/l.jpg"},
                                 {name: "Breaking Bread", img_url: "http://s3-media1.fl.yelpcdn.com/bphoto/efufJEZ0aSItXe76epfNZg/l.jpg"},
                                ]

    customers = Customer.create [{email: "justin@tradecraft.com", birthday: "1985-12-30"},
                                 {email: "wen@tradecraft.com",    birthday: "1985-12-30"},
                                ]

    # add the first location to each customer
    customers.each do |customer|
      customer.locations << Location.first
      customer.save
    end




#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
