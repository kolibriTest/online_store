class Product < ApplicationRecord
  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  has_many :product_categories
  has_many :categories, through: :product_categories

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
