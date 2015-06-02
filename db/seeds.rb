# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
    users = User.create [{first_name: "David", last_name: "Ladowitz", email: "david@ladowitz.com", admin: true, password: "asdfasdf"},
                         {first_name: "Teresa", last_name: "Huang", email: "teresa@gmail.com", admin: true, password: "asdfasdf"}
                        ]

    locations = Location.create [{name: "Jackson Place Cafe", img_url: "http://www.fillmurray.com/500/300"},
                                 {name: "YoYo's", img_url: "http://www.fillmurray.com/500/300"}
                                ]
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
