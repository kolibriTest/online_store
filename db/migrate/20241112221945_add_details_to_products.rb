class AddDetailsToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :details, :text
  end
end
