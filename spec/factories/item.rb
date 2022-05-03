# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    type              { %w[HodinkeeItem CrownandcaliberItem BobswatchesItem].sample }
    price             { Faker::Commerce.price(range: 0..100_000.0, as_string: true) }
    currency          { %w[usd eur uah].sample }
    case_dimensions   { Faker::Number.between(from: 26.0, to: 60.0).round(1).to_s }
    external_id       { Faker::Internet.uuid }
    image_uri         { Faker::Internet.url  }

    sequence(:brand) { |n| "#{Faker::Commerce.brand}#{n}" }
    sequence(:model) { |n| "#{Faker::Commerce.product_name}#{n}" }
    sequence(:dial_color) { |n| "#{Faker::Commerce.color}#{n}" }
    sequence(:case_material) { |n| "#{Faker::Commerce.material}#{n}" }
    sequence(:bracelet_material) { |n| "#{Faker::Commerce.material}#{n}" }
    sequence(:movement_type) { |n| "#{Faker::Lorem.word}#{n}" }
    initialize_with { (type.safe_constantize || Item).new }
  end
end
