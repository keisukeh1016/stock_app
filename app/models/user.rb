class User < ApplicationRecord
  has_many :portfolios, dependent: :destroy
  has_many :stocks, through: :portfolios

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { maximum: 6 }
end
