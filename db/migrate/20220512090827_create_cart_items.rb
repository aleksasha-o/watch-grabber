class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.references :item, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
    end
  end
end
