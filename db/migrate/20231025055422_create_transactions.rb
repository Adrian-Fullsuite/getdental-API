class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :dentist, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.integer :amount
      t.string :currency

      t.timestamps
    end
  end
end
