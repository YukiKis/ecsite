class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :customer
  
  enum :payment ["現金", "クレジットカード"]
  
  validates :payment, numericality: true
  validates :postcode, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :sihpment, numericality: true
end
