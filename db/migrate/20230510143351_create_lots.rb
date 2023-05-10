class CreateLots < ActiveRecord::Migration[7.0]
  def change
    create_table :lots do |t|
      t.string :code
      t.date :start_date
      t.date :end_date
      t.integer :minimum_value
      t.integer :minimal_difference
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.references :approved_by, null: true, foreign_key: { to_table: :users }
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
