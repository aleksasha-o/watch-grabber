# frozen_string_literal: true

class Item < ApplicationRecord
  validates :type, presence: true
end
