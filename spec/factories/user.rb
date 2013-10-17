FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "first_#{n}" }
    sequence(:last_name) { |n| "last_#{n}" }
    sequence(:email) { |n| "foo_#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end
end
