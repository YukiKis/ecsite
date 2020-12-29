FactoryBot.define do
  factory :order_item do
    order { nil }
    item { nil }
    amount { 1 }
  end
end
