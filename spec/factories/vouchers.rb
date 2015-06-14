# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :voucher do
    token "abc123xyz"
    association :location
    association :customer
    redeemed false
  end
end
