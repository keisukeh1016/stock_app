class AddIndexToUsersPortfolioAgerage < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :portfolio_average
  end
end
