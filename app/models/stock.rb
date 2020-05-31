class Stock < ApplicationRecord
  self.primary_key = :code

  validates :code, presence: true
  validates :code, uniqueness: true
  validates :code, length: { is: 4 }

  validates :dod_change, presence: true
end