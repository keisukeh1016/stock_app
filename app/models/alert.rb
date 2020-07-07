class Alert < ApplicationRecord
  belongs_to :user
  belongs_to :stock, foreign_key: "stock_code"

  validates :user_id, presence: true
  validates :stock_code, presence: true
  validates :comparison, presence: true
  validates :price, presence: true
end