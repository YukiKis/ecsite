class Item < ApplicationRecord
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  
  attachment :image
  
  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: true
  
  scope :active, ->(){ where(is_active: true) }
  
  TAX = 1.1
  
  def price_with_tax
    (self.price * TAX).to_i
  end
end
