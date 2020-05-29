require 'open-uri'

namespace :stock do
  desc "銘柄コードを追加する"
  task code: :environment do
    sheet = Roo::Spreadsheet.open(Rails.root.to_s + '/app/assets/spreadsheets/TOPIX_weight_jp.xlsx')
    sheet.each do |row|
      Stock.create(code: row[2]) if /\A\d{4}\Z/ === row[2].to_s && Stock.find_by(code: row[2]) == nil
    end
  end

  desc "銘柄名を更新する"
  task name: :environment do
    Stock.all.each do |stock|
      stock.update(name: stock_name(stock))
    end
  end
  
  desc "株価をリセットする"
  task reset_price: :environment do
    break if jpx_holiday?(Time.zone.now.in_time_zone("Tokyo"))
    Stock.all.each do |stock|
      stock.update(today_price: 0.1, yesterday_price: 0.1, dod_change: 0)
    end
  end

  desc "株価を更新する"
  task update_price: :environment do
    break if jpx_holiday?(Time.zone.now.in_time_zone("Tokyo"))
    Stock.where(today_price: 0.1).each do |stock|
      price = [today_price(stock), yesterday_price(stock)]
      dod_change = (price[0] - price[1]) / price[1] * 100
      stock.update(today_price: price[0], yesterday_price: price[1], dod_change: dod_change)
    end
  end 
end

# https://www.jpx.co.jp/corporate/about-jpx/calendar/index.html
JPX_HOLIDAY = { 1  => [1, 2, 3, 13],
                2  => [11, 23, 24],
                3  => [20],
                4  => [29],
                5  => [3, 4, 5, 6],
                7  => [23, 24],
                8  => [10],
                9  => [21, 22],
                11 => [3, 23],
                12 => [31]          }

def stock_name(stock)
  html = URI.open("https://minkabu.jp/stock/#{stock.code}/daily_bar")
  Nokogiri::HTML(html).css("p.md_stockBoard_stockName").to_s.match(/>(.*)</)[1]
end

def today_price(stock)
  html = URI.open("https://minkabu.jp/stock/#{stock.code}/daily_bar")
  price = Nokogiri::HTML(html).css("div.stock_price").to_s.delete(",").match(/>\n\s*(\d*\.)<.*>(\d)/)
  (price[1] + price[2]).to_f
end

def yesterday_price(stock)
  html = URI.open("https://minkabu.jp/stock/#{stock.code}/daily_bar")
  Nokogiri::HTML(html).css("#fourvalue_timeline tr:nth-child(2)>td:nth-child(5)").to_s.match(/>(.*)</)[1].delete(",").to_f
end

def jpx_holiday?(today)
  today.on_weekend? == true || JPX_HOLIDAY[today.month].include?(today.day) == true
end