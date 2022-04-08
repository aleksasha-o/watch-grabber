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

  after_create :count_items
  after_destroy :count_items

  private

  def count_items
    Redis.new.set('items_number', Item.count)
  end
end
