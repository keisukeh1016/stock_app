class AddIndexToPortfolios < ActiveRecord::Migration[6.0]
  def change
    rename_column :portfolios, :stock_id, :stock_code
    add_index :portfolios, :user_id
    add_index :portfolios, :stock_code
    add_index :portfolios, [:user_id, :stock_code], unique: true    
  end
end
