FactoryBot.define do
  factory :item do
    name { Faker::Lorem.sentence(word_count:3)  }
    description { Faker::Lorem.sentence}
    unit_price { Faker::Number.number(digits: 5)}
    association :merchant
  end
end