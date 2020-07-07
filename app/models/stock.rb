class Stock < ApplicationRecord
  self.primary_key = :code
  
  has_many :portfolios, foreign_key: "stock_code",
                        dependent: :destroy
  has_many :users, through: :portfolios
  has_many :alerts, dependent: :destroy

  validates :code, presence: true,
                   uniqueness: true,
                   length: { is: 4 }
                   
  def code_and_name 
    "#{code} #{name[0..10]}"
  end

  def day_change
    (today_price - yesterday_price) / yesterday_price * 100 
  end
end
