class AddCurrencyToItems < ActiveRecord::Migration[6.0]
  def change
    create_enum :item_currency, %w[usd eur uah]

    add_column :items, :currency, :item_currency, null: false
  end
end
