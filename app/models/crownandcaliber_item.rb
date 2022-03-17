# frozen_string_literal: true

class CrownandcaliberItem < Item
  MIN_FEATURE_LENGTH = 2

  store_accessor :features, :papers, :box, :year, :gender, :crystal, :condition,
                 :caseback, :power_reserve, :lug_width, :bezel_material, :manual,
                 :max_wrist_size, :case_thickness

  validates :papers, :box, :year, :gender, :crystal, :condition, :caseback, :power_reserve,
            :lug_width, :bezel_material, :manual, :max_wrist_size, :case_thickness,
            length: { minimum: MIN_FEATURE_LENGTH }, allow_blank: true
end
