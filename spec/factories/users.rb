FactoryBot.define do
  factory :user do
    name                  {Faker::Name.initials(number: 2)}
    account               {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)}
    password_confirmation {password}
  end
end
