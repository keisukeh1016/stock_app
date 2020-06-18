Faker::Config.locale = 'ja'

# 銘柄を追加
sheet = Roo::Spreadsheet.open(Rails.root.to_s + '/app/assets/spreadsheets/TOPIX_weight_jp.xlsx')
sheet.each do |row|
  Stock.create(code: row[2]) if row[5] == "TOPIX Core30" || row[5] == "TOPIX Large70"
end

# テストユーザーを追加
User.create(
  name: "test",
  email: "test@example.com",
  password: "testpass",
  activated: true
)

# ユーザーを追加
50.times do
  user = User.create(
    name: Faker::Name.unique.first_name,
    email: Faker::Internet.unique.safe_email,
    password: "password",
    activated: true
  )
end

