# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    type              { Item::TYPES.sample }
    price             { Faker::Commerce.price(range: 0..100_000.0, as_string: true) }
    currency          { Item.currencies.values.sample }
    case_dimensions   { Faker::Number.between(from: 26.0, to: 60.0).round(1).to_s }
    external_id       { Faker::Internet.uuid }
    image_uri         { Faker::Internet.url  }

    initialize_with { (type.safe_constantize || Item).new }
  end
end
