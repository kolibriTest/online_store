class Product < ApplicationRecord
  has_one_attached :image

  has_many :product_categories
  has_many :categories, through: :product_categories
end
