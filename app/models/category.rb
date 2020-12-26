class Category < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, presence: true
  
  scope :active, ->(){ where(is_active: true) }
end

