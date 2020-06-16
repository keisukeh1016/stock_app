class User < ApplicationRecord
  attr_accessor :activation_token
  before_create :create_activation_digest

  has_many :portfolios, dependent: :destroy
  has_many :stocks, through: :portfolios

  validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 8 }
  validates :email, presence: true,
                    uniqueness: true 
  has_secure_password
  validates :password, presence: true,
                       length: { minimum: 6 }

  def day_change
    if portfolios.count > 0
      stocks.average('(today_price - yesterday_price) / yesterday_price * 100') + 0.0001
    else
      0
    end
  end

  private
    def create_activation_digest
      self.activation_token = SecureRandom.urlsafe_base64
      self.activation_digest = BCrypt::Password.create(activation_token)
    end
end