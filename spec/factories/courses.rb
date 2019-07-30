FactoryBot.define do
  factory :course do
    sequence(:name)   { |n| "Course ##{n}" }
    sequence(:author) { |n| "Author ##{n}" }
    association       :category, factory: :category
    state             { Course.states['active'] }
  end
end
