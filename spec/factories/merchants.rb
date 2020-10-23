require 'faker'

FactoryBot.define do
  factory :merchant do
    name { Faker::Science.unique.element }
  end
end
