# frozen_string_literal: true

class Item < ApplicationRecord
  enum currency: {
    usd: USD = 'USD',
    eur: EUR = 'EUR',
    uah: UAH = 'UAH'
  }, _prefix: true
  validates :type, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :currency, presence: true, if: :price
end
