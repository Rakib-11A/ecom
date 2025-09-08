class CreateStocks < ActiveRecord::Migration[8.0]
  def change
    create_table :stocks do |t|
      t.integer :size
      t.integer :amount
      t.references :admin_product, null: false, foreign_key: true

      t.timestamps
    end
    add_index :stocks, [ :admin_product_id, :size ]
  end
end
