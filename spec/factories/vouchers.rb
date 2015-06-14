# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :voucher do
    association :location
    association :customer
    redeemed false
  end
end
