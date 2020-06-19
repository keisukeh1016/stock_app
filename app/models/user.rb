class User < ApplicationRecord
  attr_accessor :activation_token
  has_secure_password

  before_create :create_activation_digest
  after_create :create_wallet_cash

  has_one :wallet, dependent: :destroy
  has_many :portfolios, dependent: :destroy
  has_many :stocks, through: :portfolios

  validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 8 }
  validates :email, presence: true,
                    uniqueness: true 
  validates :password, presence: true,
                       length: { minimum: 6 }

  def total_assets
    stocks.sum("today_price * holding") + wallet.cash
  end

  def already_has?(portfolio)
    portfolios.find_by(id: portfolio.id) ? true : false
  end

  def already_has_portfolios_more_than_4?
    portfolios.count > 4
  end

  private
    def create_wallet_cash
      create_wallet
    end

    def create_activation_digest
      self.activation_token = SecureRandom.urlsafe_base64
      self.activation_digest = BCrypt::Password.create(activation_token)
    end
end