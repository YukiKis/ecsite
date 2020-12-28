class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  def subtotal
    item.price_with_tax * amount
  end  
end
