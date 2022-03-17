# frozen_string_literal: true

class BobswatchesItem < Item
  MIN_FEATURE_LENGTH = 2

  store_accessor :features, :box_and_papers, :year, :gender, :condition, :regular_price

  validates :box_and_papers, :year, :gender, :condition, :regular_price,
            length: { minimum: MIN_FEATURE_LENGTH }, allow_blank: true
end
