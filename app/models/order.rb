class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :customer
  
  enum payment: { "クレジットカード": 0, "銀行振込": 1 }
  
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
end