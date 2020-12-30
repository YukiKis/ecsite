class Category < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, presence: true
  
  scope :active, ->(){ where(is_active: true) }
  
  def status
    if self.is_active == true
      "有効"
    else
      "無効"
    end
  end
end

