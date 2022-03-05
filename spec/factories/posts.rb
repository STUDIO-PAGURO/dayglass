FactoryBot.define do
  factory :post do
    text {Faker::Lorem.sentence}
    association :user

    after(:build) do |post|
      post.image.attach(io: File.open("public/images/test_image.jpg"), filename: "test_image.jpg")
    end
  end
end