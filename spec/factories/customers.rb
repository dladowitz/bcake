# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    email "russ@tradecraft.com"
    birthday "1983-12-25"
  end
end
