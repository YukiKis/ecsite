FactoryBot.define do
  factory :order do
    payment { 1 }
    postcode { "5200815" }
    address { "滋賀県" }
    name { "母" }
    shipment { 800 }
    status { 0 }
  end
end
