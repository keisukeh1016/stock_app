class Stock < ApplicationRecord
  validates :code, :name, :today_price, :yesterday_price, :dod_change, presence: true
  validates :code, :today_price, :yesterday_price, :dod_change, numericality: true
  
  validates :code, length: { is: 4 }, uniqueness: true
end