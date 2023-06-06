class CreateBlockedCpfs < ActiveRecord::Migration[7.0]
  def change
    create_table :blocked_cpfs do |t|
      t.string :cpf
      t.references :blocked_by, null: false, foreign_key: { to_table: :users }
      t.string :reason

      t.timestamps
    end
  end
end
