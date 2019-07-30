FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category ##{n}" }
    association     :vertical, factory: :vertical
    state           { Category.states['active'] }
  end
end
