# frozen_string_literal: true

class Item < ApplicationRecord
  TYPES = %w[HodinkeeItem CrownandcaliberItem BobswatchesItem].freeze

  enum currency: {
    usd: 'usd',
    eur: 'eur',
    uah: 'uah'
  }, _prefix: true
  validates :type, :price, :currency, :external_id, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :external_id, uniqueness: true

  scope :by_brands, lambda { |brands|
    return all if brands.blank?

    where(brands.map { |brand| "brand ILIKE '%#{brand}%'" }.join(' OR '))
  }
  scope :by_model, ->(model) { model.blank? ? all : where('model ILIKE ?', "%#{model}%") }
  scope :by_dial_color, ->(dial_color) { dial_color.blank? ? all : where('dial_color ILIKE ?', "%#{dial_color}%") }
  scope :by_case_material, lambda { |case_material|
    case_material.blank? ? all : where('case_material ILIKE ?', "%#{case_material}%")
  }
  scope :by_case_dimensions, lambda { |case_dimensions|
    case_dimensions.blank? ? all : where('case_dimensions ILIKE ?', "%#{case_dimensions}%")
  }
  scope :by_bracelet_material, lambda { |bracelet_material|
    return all if bracelet_material.blank?

    where('bracelet_material ILIKE ?', "%#{bracelet_material}%")
  }
  scope :by_movement_type, lambda { |movement_type|
    movement_type.blank? ? all : where('movement_type ILIKE ?', "%#{movement_type}%")
  }

  scope :ordered_by_brand_asc, -> { order(brand: :asc) }
  scope :ordered_by_brand_desc, -> { order(brand: :desc) }
  scope :ordered_by_price_asc, -> { order(price: :asc) }
  scope :ordered_by_price_desc, -> { order(price: :desc) }

  scope :by_price, lambda { |min_price: 0, max_price: nil|
    query = all
    query = query.where('price >= ?', min_price) if min_price.to_f.positive?
    query = query.where('price <= ?', max_price) if max_price.present?
    query
  }
end
