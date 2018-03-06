FactoryBot.define do
  sequence(:name){ |n| "TestTag#{n}" }

  factory :tag do
    name
    posts_count 0
  end
end