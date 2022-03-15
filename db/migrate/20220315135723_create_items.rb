# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string  :brand
      t.string  :model
      t.decimal :price, precision: 10, scale: 2
      t.string  :currency
      t.text    :dial_color
      t.text    :case_material
      t.text    :case_dimensions
      t.text    :bracelet_material
      t.text    :movement_type

      t.text    :box_and_papers
      t.integer :year
      t.string  :gender
      t.text    :condition
      t.string  :regular_price
      t.text    :papers
      t.text    :box
      t.text    :crystal
      t.text    :caseback
      t.text    :power_reserve
      t.text    :lug_width
      t.text    :bezel_material
      t.text    :manual
      t.text    :max_wrist_size
      t.text    :case_thickness
      t.text    :water_resistance
      t.text    :reference_number
      t.text    :functions
      t.text    :manufactured
      t.text    :lume

      t.timestamps
    end
  end
end
