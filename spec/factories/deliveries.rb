FactoryBot.define do
  factory :delivery do
    customer { nil }
    postcode { "MyString" }
    address { "MyString" }
    name { "MyString" }
  end
end
