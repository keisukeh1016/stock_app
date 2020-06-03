# 銘柄を追加
sheet = Roo::Spreadsheet.open(Rails.root.to_s + '/app/assets/spreadsheets/TOPIX_weight_jp.xlsx')
sheet.each do |row|
  Stock.create(code: row[2]) if row[5] == "TOPIX Core30" || row[5] == "TOPIX Large70"
end

# ユーザーとポートフォリオを追加
Faker::Config.locale = 'ja'
arr = Stock.pluck(:code).shuffle

50.times do
  user = User.create(name: Faker::Name.unique.first_name)
  arr.shuffle!
  5.times { |n| user.portfolios.create(stock_code: arr[n]) }
end