class CreateCurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :currencies do |t|
      t.string :country
      t.string :currency_name
      t.string :currency_code
      t.integer :amount
      t.decimal :rate
      t.date :valid_for

      t.timestamps
    end

    add_index :currencies, :currency_code, unique: true
  end
end
