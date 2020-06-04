class Portfolio < ApplicationRecord
  belongs_to :user
  belongs_to :stock, foreign_key: "stock_code"

  validates :user_id, presence: true,
                      uniqueness: { scope: :stock_code }
  validates :stock_code, presence: true,
                         uniqueness: { scope: :user_id }
  validate :user_cannot_have_portfolios_more_than_5

  def user_cannot_have_portfolios_more_than_5
    errors.add(:base, "銘柄登録の上限は５件です") if user.portfolios.count > 4
  end
end