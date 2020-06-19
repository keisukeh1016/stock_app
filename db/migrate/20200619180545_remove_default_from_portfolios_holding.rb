class RemoveDefaultFromPortfoliosHolding < ActiveRecord::Migration[6.0]
  def change
    change_column_default :portfolios, :holding, from: 1, to: nil
  end
end
