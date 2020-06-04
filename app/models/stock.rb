class Stock < ApplicationRecord
  self.primary_key = :code
  
  has_many :portfolios, foreign_key: "stock_code",
                        dependent: :destroy
  has_many :users, through: :portfolios

  validates :code, presence: true,
                   uniqueness: true,
                   length: { is: 4 }
  validates :dod_change, presence: true
end
