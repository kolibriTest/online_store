class CreateCartItemsTable < ActiveRecord::Migration[7.2]
  def change
    create_table :cart_items_tables do |t|
      t.timestamps
    end
  end
end
