class DropStocksTable < ActiveRecord::Migration[8.0]
  def up
    drop_table :stocks
  end

  # def down
  #   create_table :stocks do |t|
  #     t.integer :size
  #     t.integer :amount
  #     t.integer :admin_product_id
  #     t.references :admin_product, null: false, foreign_key: true
  #   end
  # end
end
