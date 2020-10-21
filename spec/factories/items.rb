require 'faker'

FactoryBot.define do
  factory :item do
    name { Faker::Commerce.unique.product_name }
    description { Faker::Food.description }
    unit_price { Faker::Commerce.price(range: 0..20.0) }
  end
end
