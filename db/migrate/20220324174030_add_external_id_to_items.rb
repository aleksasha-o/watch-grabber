class AddExternalIdToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :external_id, :string
    add_index :items, :external_id, unique: true
  end
end
