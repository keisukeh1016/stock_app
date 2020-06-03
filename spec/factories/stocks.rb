FactoryBot.define do
  factory :stock do
    code { 1000 }
    name { "テスト株式会社" }
    today_price { 110 }
    yesterday_price { 100 }
    dod_change { 10 }
  end
end