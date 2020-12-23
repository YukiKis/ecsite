FactoryBot.define do
  factory :customer, class: Customer do
    last_name { "岸" }
    first_name { "優" }
    last_name_kana { "きし" }
    first_name_kana { "ゆう" }
    postcode { "5200815" }
    address { "滋賀県" }
    tel { "01234567890" }
    email { "yuki@com" }
    password { "testtest" }
  end
end