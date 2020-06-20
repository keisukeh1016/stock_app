FactoryBot.define do
  factory :stock do
    code { 1234 }
    name { '株式会社テスト' }
    today_price { 10000 }
  end
end