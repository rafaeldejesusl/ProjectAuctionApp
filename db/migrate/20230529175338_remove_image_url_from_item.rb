class RemoveImageUrlFromItem < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :item, :string
  end
end
