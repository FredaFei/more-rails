FactoryBot.define do
  factory :record do
    amount { 10000 }
    category { "outgoings" }
    user
  end
end