class User < ApplicationRecord
  has_many :portfolios, dependent: :destroy
  has_many :stocks, through: :portfolios

  validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 8 }
end
