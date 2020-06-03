class Portfolio < ApplicationRecord
  belongs_to :user
  belongs_to :stock, foreign_key: "stock_code"

  validates :user_id, presence: true
  validates :stock_code, presence: true
  validate :user_cannot_have_portfolios_more_than_5

  def user_cannot_have_portfolios_more_than_5
    errors.add(:base, "銘柄登録の上限は５件です") if user.portfolios.count > 4
  end
end