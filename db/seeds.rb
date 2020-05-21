require 'spreadsheet'

path = Rails.root.to_s + '/app/assets/xls/data_j.xls'
book = Spreadsheet.open path
sheet = book.worksheet 0

sheet.each_with_index do |stock, i|
  next if i == 0
  Stock.create(code: stock[1].to_i, name: stock[2])
end