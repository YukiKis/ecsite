class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :customer
  
  enum payment: { "クレジットカード": 0, "銀行振込": 1 }
  enum status: { "入金待ち": 0, "作成中": 1, "発送済み": 2 }
  validates :payment, presence: true
  validates :postcode, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :shipment, numericality: true
  
  def set_order_items(customer)
    customer.cart_items.map do |cart_item|
      self.order_items.create(item: cart_item.item, amount: cart_item.amount)
    end
  end
  
  def subtotal_price
    self.order_items.inject(0){ |result, order_item| result += order_item.item.price_with_tax }.to_s(:delimited)
  end
  
  def total_price
    self.order_items.inject(self.shipment){ |result, order_item| result += order_item.item.price_with_tax }.to_s(:delimited)
  end
end