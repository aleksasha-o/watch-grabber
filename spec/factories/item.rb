# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    type              { %w[HodinkeeItem CrownandcaliberItem BobswatchesItem].sample }
    brand             { Faker::Commerce.brand }
    model             { Faker::Commerce.product_name }
    price             { Faker::Commerce.price(range: 0..100_000.0, as_string: true) }
    currency          { %w[usd eur uah].sample }
    dial_color        { Faker::Commerce.color }
    case_material     { Faker::Commerce.material }
    case_dimensions   { Faker::Number.between(from: 26.0, to: 60.0).round(1).to_s }
    bracelet_material { Faker::Commerce.material }
    movement_type     { Faker::Lorem.word }
    external_id       { Faker::Internet.uuid }
    image_uri         { Faker::Internet.url  }

    initialize_with { (type.safe_constantize || Item).new }
  end
end
