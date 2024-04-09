FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.number(digits:2) }
    unit_price { Faker::Number.number(digits: 5)}
    status { "packaged" }
    association :invoice
    association :item

  end
end