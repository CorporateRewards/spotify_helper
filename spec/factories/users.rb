FactoryBot.define do
  factory :user do
    first_name { 'Gill' }
    last_name { 'Man' }
    sequence(:email) { |n| "test#{n}@createk.io" }
    password { '12345678' }
  end
end
