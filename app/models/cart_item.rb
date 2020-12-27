class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  validates :amount, numericality: true
  
  def subtotal_price
    item.price_with_tax * amount
  end
end
