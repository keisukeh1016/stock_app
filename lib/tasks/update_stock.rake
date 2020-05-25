require 'open-uri'

namespace :update_stock do 
  
  desc "銘柄コードを更新する"
  task list: :environment do
    Stock.destroy_all
    sheet = Roo::Spreadsheet.open(Rails.root.to_s + '/app/assets/spreadsheets/TOPIX_weight_jp.xlsx')
    sheet.each do |row|
      Stock.create(code: row[2]) if /\A\d{4}\Z/ === row[2].to_s
    end
  end

  desc "銘柄名を更新する"
  task name: :environment do
    Stock.all.each do |stock|
      stock.update(name: name(stock))
    end
  end

  desc "株価を更新する"
  task price: :environment do 
    Stock.all.each do |stock|
      stock.update(price: price(stock))
    end
  end 

end

def price(stock)
  html = URI.open("https://www.bloomberg.co.jp/quote/#{stock.code}:JP")
  Nokogiri::HTML(html).css("div.price").to_s.delete(",").match(/\d+\.\d*/).to_s.to_f
end

def name(stock)
  html = URI.open("https://www.bloomberg.co.jp/quote/#{stock.code}:JP")
  Nokogiri::HTML(html).css("h1.name").to_s.match(/>\s(.*)\s</)[1]
end