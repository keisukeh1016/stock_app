FactoryBot.define do
  factory :portfolio do
    user
    stock
    holding { 1 }
  end
end 