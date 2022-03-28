class AddImageUriToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :image_uri, :string
  end
end
