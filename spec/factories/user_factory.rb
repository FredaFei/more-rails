FactoryBot.define do
  factory :user do
    email { "#{SecureRandom.hex 9}@qq.com" }
    password { "123456" }
    password_confirmation { "123456" }
  end
end