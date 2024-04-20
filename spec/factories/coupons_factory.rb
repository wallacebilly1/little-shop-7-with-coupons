FactoryBot.define do
  factory :coupon do
    name { Faker::Lorem.characters(number: 6) }
    code { Faker::Alphanumeric.unique.alphanumeric(number: 6, min_alpha: 4, min_numeric: 2) }
    status { "disabled" }
    disc_int { Faker::Number.number(digits:2) }
    disc_type { Faker::Number.between(from: 0, to: 1) }
    association :merchant 
  end
end