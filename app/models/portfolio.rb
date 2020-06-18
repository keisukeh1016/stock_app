class Portfolio < ApplicationRecord
  belongs_to :user
  belongs_to :stock, foreign_key: "stock_code"

  validates :user_id, presence: true,
                      uniqueness: { scope: :stock_code }
  validates :stock_code, presence: true,
                         uniqueness: { scope: :user_id }
  validates :holding, presence: true,
                      numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :user_cannot_have_portfolios_more_than_5
  validate :user_cannot_buy_more_than_cash

  def total_value
    stock.today_price * holding
  end

  def already_holding
    if user.portfolios.find_by(stock_code: stock_code)
      user.portfolios.find_by(stock_code: stock_code).holding
    else
      0
    end
  end

  def already_exist_more_than_4?
    user.stocks.ids.include?(stock_code) == false && user.portfolios.count > 4
  end

  private
    def user_cannot_have_portfolios_more_than_5
      errors.add(:base, "銘柄登録の上限は５件です") if already_exist_more_than_4?
    end

    def user_cannot_buy_more_than_cash
      if stock.today_price * (holding - already_holding) > user.wallet.cash
        errors.add(:base, "現金が不足しています")
      end
    end
end