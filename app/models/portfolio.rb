class Portfolio < ApplicationRecord
  before_save :update_wallet_cash
  before_destroy :reset_holding, :update_wallet_cash

  belongs_to :user
  belongs_to :stock, foreign_key: "stock_code"

  validates :user_id, presence: true,
                      uniqueness: { scope: :stock_code }
  validates :stock_code, presence: true,
                         uniqueness: { scope: :user_id }
  validates :holding, presence: true,
                      numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :user_cannot_has_portfolios_more_than_5
  validate :user_cannot_buy_more_than_cash

  def total_value
    stock.today_price * holding
  end

  def already_holding
    user.already_has?(self) ? user.portfolios.find(id).holding : 0
  end

  def after_cash
    user.wallet.cash - ( stock.today_price * (holding - already_holding) )
  end

  def excess_count_limit?
    user.already_has?(self) == false && user.already_has_portfolios_more_than_4?
  end

  def user_has_enough_money?
    after_cash >= 0
  end

  private
    def reset_holding
      self.holding = 0
    end

    def update_wallet_cash
      user.wallet.update!(cash: after_cash)
    end

    def user_cannot_has_portfolios_more_than_5
      errors.add(:base, "銘柄登録の上限は５件です") if excess_count_limit?
    end

    def user_cannot_buy_more_than_cash
      errors.add(:base, "現金が不足しています") unless user_has_enough_money?
    end
end