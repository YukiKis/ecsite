FactoryBot.define do
  factory :item1, class: Item do
    image_id { "a" }
    name { "ケーキ1" }
    description { "eg1" }
    price { 1000 }
    is_active { true }
  end
    factory :item2, class: Item do
    image_id { "a" }
    name { "プリン1" }
    description { "eg1" }
    price { 100 }
    is_active { true }
  end
    factory :item3, class: Item do
    image_id { "a" }
    name { "焼き菓子1" }
    description { "eg1" }
    price { 160 }
    is_active { true }
  end
  factory :item4, class: Item do
    image_id { "a" }
    name { "アイスキャンディ1" }
    description { "eg4" }
    price { 200 }
    is_active { true }
  end
  
end