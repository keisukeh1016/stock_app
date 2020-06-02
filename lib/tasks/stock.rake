require 'open-uri'

namespace :stock do
  desc "銘柄コードを追加する"
  task code: :environment do
    sheet = Roo::Spreadsheet.open(Rails.root.to_s + '/app/assets/spreadsheets/TOPIX_weight_jp.xlsx')
    sheet.each do |row|
      Stock.create(code: row[2]) if row[5] == "TOPIX Core30" || row[5] == "TOPIX Large70"
    end
  end

  desc "銘柄名を更新する"
  task name: :environment do
    Stock.all.each do |stock|
      stock.update(name: stock_name(stock))
    end
  end
  
  desc "株価を更新する"
  task price: :environment do
    break if jpx_holiday?(Time.zone.now)

    Stock.all.each do |stock|
      price = [today_price(stock), yesterday_price(stock)]
      dod_change = (price[0] - price[1]) / price[1] * 100
      stock.update(today_price: price[0], yesterday_price: price[1], dod_change: dod_change)
    end

    User.all.each do |user|
      arr = user.stocks.pluck(:dod_change)
      average = arr.empty? ? 0 : arr.sum / arr.length
      user.update(portfolio_average: average)
    end
  end 

  desc "株価を更新する（手動用）"
  task price_man: :environment do
    Stock.all.each do |stock|
      price = [today_price(stock), yesterday_price(stock)]
      dod_change = (price[0] - price[1]) / price[1] * 100
      stock.update(today_price: price[0], yesterday_price: price[1], dod_change: dod_change)
    end
    
    User.all.each do |user|
      arr = user.stocks.pluck(:dod_change)
      average = arr.empty? ? 0 : arr.sum / arr.length
      user.update(portfolio_average: average)
    end
  end 
end

# https://www.jpx.co.jp/corporate/about-jpx/calendar/index.html
JPX_HOLIDAY = { 1  => [1, 2, 3, 13],
                2  => [11, 23, 24],
                3  => [20],
                4  => [29],
                5  => [3, 4, 5, 6],
                6  => [],
                7  => [23, 24],
                8  => [10],
                9  => [21, 22],
                10 => [],
                11 => [3, 23],
                12 => [31] }

def stock_name(stock)
  html = URI.open("https://minkabu.jp/stock/#{stock.code}")
  data = Nokogiri::HTML(html).css(".md_stockBoard_stockName").to_s.match(/>(.*)</)
  data ? data[1] : nil
end

def today_price(stock)
  html = URI.open("https://www.bloomberg.co.jp/quote/#{stock.code}:JP")
  data = Nokogiri::HTML(html).css(".price").to_s.match(/>(.*)</)
  data ? data[1].delete(",").to_f : 1
end

def yesterday_price(stock)
  html = URI.open("https://www.bloomberg.co.jp/quote/#{stock.code}:JP")
  data = Nokogiri::HTML(html).css(".data-table_detailed>div:nth-child(4)>div:nth-child(2)").to_s.match(/>\s(.*)\s</)
  data ? data[1].delete(",").to_f : 1
end

def jpx_holiday?(date)
  t = date.in_time_zone("Tokyo")
  t.on_weekend? || JPX_HOLIDAY[t.month].include?(t.day)
end