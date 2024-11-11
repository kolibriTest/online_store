class ProductDetail < ApplicationRecord
  belongs_to :product

  validates :manufacturer, :warranty, :dimensions, :weight, presence: true
end
