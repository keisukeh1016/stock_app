class Wallet < ApplicationRecord
  belongs_to :user

  validates :cash, presence: true,
                   numericality: { greater_than_or_equal_to: 0 }
end