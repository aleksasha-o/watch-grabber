# frozen_string_literal: true

class HodinkeeItem < Item
  store_accessor :features, :crystal, :water_resistance, :reference_number, :functions,
                 :caseback, :power_reserve, :manufactured, :lug_width, :lume
end
