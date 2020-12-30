class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  enum status: { "着手不可": 0, "作成中": 1, "作成済み": 2 }
  
  def subtotal
    item.price_with_tax * amount
  end  
end
