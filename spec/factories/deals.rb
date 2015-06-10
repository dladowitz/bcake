# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :deal do
    association :location
    birthday_deal "Free Panini"
    monthly_deal "MyString"
  end
end
