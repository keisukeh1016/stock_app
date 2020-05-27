class RenameStocksPriceToTodayPrice < ActiveRecord::Migration[6.0]
  def change
    rename_column :stocks, :price, :today_price
  end
end
