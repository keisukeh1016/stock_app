FactoryBot.define do
  factory :user do
    name { 'Bob' }
    email { 'user@example.com' }
    password { 'password' }
    activated { true }
  end
end