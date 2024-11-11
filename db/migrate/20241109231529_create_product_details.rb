class CreateProductDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :product_details do |t|
      t.references :product, null: false, foreign_key: true
      t.string :manufacturer
      t.string :warranty
      t.string :dimensions
      t.decimal :weight

      t.timestamps
    end
  end
end
