# frozen_string_literal: true

class Item < ApplicationRecord
  enum currency: {
    usd: 'usd',
    eur: 'eur',
    uah: 'uah'
  }, _prefix: true
  validates :type, :price, :currency, :external_id, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :external_id, uniqueness: true

  scope :min_max_price, ->(min_price, max_price) { where('price > ? AND price < ?', min_price, max_price) }

  scope :by_brands, ->(brands) { where(brands.map { |brand| "brand ILIKE '%#{brand}%'" }.join(' OR ')) }
  scope :by_model, ->(model) { where('model ILIKE ?', "%#{model}%") }
  scope :by_dial_color, ->(dial_color) { where('dial_color ILIKE ?', "%#{dial_color}%") }
  scope :by_case_material, ->(case_material) { where('case_material ILIKE ?', "%#{case_material}%") }
  scope :by_case_dimensions, ->(case_dimensions) { where('case_dimensions ILIKE ?', "%#{case_dimensions}%") }
  scope :by_bracelet_material, ->(bracelet_material) { where('bracelet_material ILIKE ?', "%#{bracelet_material}%") }
  scope :by_movement_type, ->(movement_type) { where('movement_type ILIKE ?', "%#{movement_type}%") }

  scope :ordered_by_brand_asc, -> { order(brand: :asc) }
  scope :ordered_by_brand_desc, -> { order(brand: :desc) }
  scope :ordered_by_price_asc, -> { order(price: :asc) }
  scope :ordered_by_price_desc, -> { order(price: :desc) }
end
