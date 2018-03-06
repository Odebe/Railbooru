
FactoryBot.define do
  sequence(:username){ |n| "TestUser#{n}" }
  sequence(:email){ |n| "user#{n}@example.com" }

  factory :user do
    username
    email
    password "password"
  end
end