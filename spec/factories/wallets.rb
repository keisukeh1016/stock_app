FactoryBot.define do
  factory :wallet do
    user
    cash { 100000 }
  end
end
