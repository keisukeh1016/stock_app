require 'open-uri'
require 'nokogiri'
require 'spreadsheet'

namespace :update_stock do 
  desc "銘柄リストを更新する"
  task list: :environment do
    sheet = Spreadsheet.open(Rails.root.to_s + '/app/assets/xls/data_j.xls').worksheet 0
    
    Stock.destroy_all
    sheet.each_with_index do |stock, i|
      next if i == 0
      Stock.create(code: stock[1].to_i.to_s, name: stock[2])
    end
  end
  
  desc "ブルームバーグから終値取得"
  task price: :environment do
    Stock.all.each do |stock|
      html = URI.open("https://www.bloomberg.co.jp/quote/#{stock.code}:JP")
      price = Nokogiri::HTML(html).css("div.price").to_s.delete(",").match(/\d+\.\d*/).to_s.to_f
  
      price_obj = Price.find_by(code: stock.code) 
      if price_obj
        price_obj.update(price: price)
      else
        Price.create(code: stock.code, price: price)
      end
    end
  end 
end
