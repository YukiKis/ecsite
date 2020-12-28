class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :deliveries, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
         
  validates :first_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name, presence: true
  validates :last_name_kana, presence: true
  validates :postcode, format: { with: /\d{7}/, message: "有効な郵便番号が必要です" }
  validates :address, presence: true
  validates :tel, presence: true
  
  def subtotal_with_all_cart_items
    self.cart_items.inject(0) do |total, cart_item|
      total += cart_item.item.price_with_tax * cart_item.amount
    end
  end
end
