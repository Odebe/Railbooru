
FactoryBot.define do
  factory :post do
    association :user, factory: :user
    #association :comments, factory: :comment
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'brands', 'logos', 'logo_image.jpg'), 'image/jpeg') }
  
    trait :with_comments do
      after(:create) do |post|
        create_list(:comment, 3, post: post)
      end
    end

  end
end
