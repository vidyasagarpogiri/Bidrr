
FactoryGirl.define do
  factory :list do
  sequence(:title) { Faker::Name.name }
   sequence(:details)  { Faker::Lorem.sentence  }
   sequence(:end_date)      { Faker::Business.credit_card_expiry_date }
   sequence(:reserve_price) {Faker::Commerce.price}
  end
end
