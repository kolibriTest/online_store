class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.date :order_date

      t.timestamps
    end
  end
end
