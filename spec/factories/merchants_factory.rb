FactoryBot.define do
  factory :merchant do
    name { Faker::Company.unique.name }
  end
end