class Payment < ApplicationRecord
  belongs_to :order

  validates :payment_type, :amount, :payment_date, presence: true
end
