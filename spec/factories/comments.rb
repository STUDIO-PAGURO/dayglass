FactoryBot.define do
  factory :comment do
    text {Faler::Lorem.sentence}
    association :user
    association :post
  end
end