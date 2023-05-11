class AddLotToItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :lot, null: true, foreign_key: true
  end
end
