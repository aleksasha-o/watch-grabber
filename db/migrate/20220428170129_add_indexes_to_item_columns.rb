class AddIndexesToItemColumns < ActiveRecord::Migration[6.0]
  def change
    add_index :items, :brand
    add_index :items, :model
    add_index :items, :dial_color
    add_index :items, :case_material
    add_index :items, :case_dimensions
    add_index :items, :bracelet_material
    add_index :items, :movement_type
    add_index :items, :price
  end
end
