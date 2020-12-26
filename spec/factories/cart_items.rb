FactoryBot.define do
  factory :cart_item do
    customer { nil }
    item { nil }
    amount { 1 }
  end
end
