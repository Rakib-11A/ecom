class CreateAdminProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :admin_products do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.references :category, foreign_key: { to_table: :admin_categories }, null: false, index: { name: "index_admin_products_on_category_id"}
      t.boolean :active

      t.timestamps
    end
  end
end
