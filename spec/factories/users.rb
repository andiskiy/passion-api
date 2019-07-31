FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email_#{n}@test.com" }
    password         { '123456' }
  end
end
