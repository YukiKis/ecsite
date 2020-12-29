FactoryBot.define do
  factory :admin, class: Admin do
    email { "admin@com" }
    password { "testtest" }
  end
end