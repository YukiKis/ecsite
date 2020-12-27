FactoryBot.define do
  factory :order do
    cart_item_id { 1 }
    payment { 1 }
    postcode { "MyString" }
    address { "MyString" }
    name { "MyString" }
    shipment { 1 }
    total { 1 }
  end
end
