FactoryBot.define do
  factory :order do
    payment { 1 }
    postcode { "MyString" }
    address { "MyString" }
    name { "MyString" }
    shipment { 1 }
  end
end
