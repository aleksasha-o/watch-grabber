# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'hstore'
    create_table :items do |t|
      t.string  :type, null: false
      t.string  :brand
      t.string  :model
      t.decimal :price, null: false, precision: 10, scale: 2
      t.string  :currency, null: false
      t.text    :dial_color
      t.text    :case_material
      t.text    :case_dimensions
      t.text    :bracelet_material
      t.text    :movement_type
      t.hstore  :features
      t.timestamps
    end
  end
end
