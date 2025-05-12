class CreateJoinTableProductsCategories < ActiveRecord::Migration[7.2]
  def change
    create_join_table :products, :categories do |t|
    end
  end
end
