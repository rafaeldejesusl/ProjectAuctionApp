class CreateBids < ActiveRecord::Migration[7.0]
  def change
    create_table :bids do |t|
      t.integer :value
      t.references :lot, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
