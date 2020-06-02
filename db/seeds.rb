require 'open-uri'

# 銘柄
sheet = Roo::Spreadsheet.open(Rails.root.to_s + '/app/assets/spreadsheets/TOPIX_weight_jp.xlsx')
sheet.each do |row|
  Stock.create(code: row[2]) if row[5] == "TOPIX Core30" || row[5] == "TOPIX Large70"
end

# ユーザー
user1 = User.create(name: 'ケイスケ')
user2 = User.create(name: '半沢直樹')
user3 = User.create(name: '自動車')
user4 = User.create(name: '電車')
user5 = User.create(name: 'はるか')

# ポートフォリオ
user1.portfolios.create(stock_code: 9984)
user1.portfolios.create(stock_code: 9983)
user1.portfolios.create(stock_code: 6098)
user1.portfolios.create(stock_code: 6861)
user1.portfolios.create(stock_code: 7974)

user2.portfolios.create(stock_code: 8604)
user2.portfolios.create(stock_code: 8411)
user2.portfolios.create(stock_code: 8316)
user2.portfolios.create(stock_code: 8308)
user2.portfolios.create(stock_code: 8306)

user3.portfolios.create(stock_code: 7201)
user3.portfolios.create(stock_code: 7270)
user3.portfolios.create(stock_code: 7203)
user3.portfolios.create(stock_code: 7267)
user3.portfolios.create(stock_code: 7269)

user4.portfolios.create(stock_code: 9022)
user4.portfolios.create(stock_code: 9021)
user4.portfolios.create(stock_code: 9020)

user5.portfolios.create(stock_code: 4911)
user5.portfolios.create(stock_code: 4452)
user5.portfolios.create(stock_code: 8113)
user5.portfolios.create(stock_code: 2802)
user5.portfolios.create(stock_code: 4661)