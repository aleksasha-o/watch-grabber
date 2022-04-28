class AddIndexesToItemPrice < ActiveRecord::Migration[6.0]
  def change
    add_index :items, :price
  end
end
