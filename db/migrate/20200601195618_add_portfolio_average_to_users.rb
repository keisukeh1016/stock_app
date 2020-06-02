class AddPortfolioAverageToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :portfolio_average, :float, default: 0
  end
end
