class Portfolio < ApplicationRecord
  belongs_to :user
  belongs_to :stock, foreign_key: "stock_code"

  validates :user_id, presence: true
  validates :stock_code, presence: true
end
