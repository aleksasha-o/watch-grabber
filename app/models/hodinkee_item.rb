# frozen_string_literal: true

class HodinkeeItem < Item
  MIN_FEATURE_LENGTH = 2

  store_accessor :features, :crystal, :water_resistance, :reference_number, :functions,
                 :caseback, :power_reserve, :manufactured, :lug_width, :lume

  validates :crystal, :water_resistance, :reference_number, :functions,
            :caseback, :power_reserve, :manufactured, :lug_width, :lume,
            length: { minimum: MIN_FEATURE_LENGTH }, allow_blank: true
end
