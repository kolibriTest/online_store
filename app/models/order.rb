class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :total, numericality: { greater_than_or_equal_to: 0 }

  # Метод для обчислення загальної суми замовлення
  def total_amount
    order_items.sum { |item| item.quantity * item.price }
  end
end
