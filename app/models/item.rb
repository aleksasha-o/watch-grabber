# frozen_string_literal: true

class Item < ApplicationRecord
  enum currency: {
    usd: 'usd',
    eur: 'eur',
    uah: 'uah'
  }, _prefix: true
  validates :type, :price, :currency, presence: true
  validates :price, numericality: { greater_than: 0 }
end
