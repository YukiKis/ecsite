class Item < ApplicationRecord
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  
  attachment :image
  
  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: true
  
  scope :active, ->(){ where(is_active: true) }
  scope :categorized, ->(category_id){ active.where(category_id: category_id).order(created_at: "ASC") }
  
  
  TAX = 1.1
  
  def price_with_tax
    (self.price * TAX).to_i
  end
  
  def status
    if self.is_active == true
      "販売中"
    else
      "販売中止"
    end
  end
end
