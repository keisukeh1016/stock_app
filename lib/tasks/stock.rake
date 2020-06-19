require 'open-uri'

namespace :stock do
  desc "銘柄名を更新する"
  task name: :environment do
    Stock.all.each do |stock|
      stock.update(name: stock_name(stock))
    end
  end
  
  desc "株価を更新する"
  task price: :environment do
    break if jpx_holiday?
    update_stocks_price
  end 

  desc "株価を更新する（手動）"
  task price_man: :environment do
    update_stocks_price    
  end 

  desc "ポートフォリオを更新する"
  task portfolio: :environment do
    shuffle_users_portfolios
  end 
end

# https://www.jpx.co.jp/corporate/about-jpx/calendar/index.html
JPX_HOLIDAY = { 1  => [1, 2, 3, 13], 2 => [11, 23, 24], 3 => [20],     4 => [29],
                5  => [3, 4, 5, 6],  6 => [],           7 => [23, 24], 8 => [10],
                9  => [21, 22],     10 => [],          11 => [3, 23], 12 => [31] }

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

def jpx_holiday?
  t = Time.zone.now
  t.on_weekend? || JPX_HOLIDAY[t.month].include?(t.day)
end

def update_stocks_price
  Stock.all.each do |stock|
    stock.update!( today_price: today_price(stock), yesterday_price: yesterday_price(stock) )
  end
end

def shuffle_users_portfolios
  code_arr = Stock.ids.shuffle
  User.where("id <= 50").each do |user|
    user.portfolios.destroy_all

    code_arr[0..4].each { |code| user.portfolios.create(stock_code: code, holding: 1) }
    
    begin
      bool_arr = []
      user.portfolios.each { |portfolio| bool_arr << portfolio.update(holding: portfolio.holding + 1) }
    end while bool_arr.include?(true)
  
    code_arr.shuffle!
  end
end