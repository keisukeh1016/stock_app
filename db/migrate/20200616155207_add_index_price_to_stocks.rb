class AddIndexPriceToStocks < ActiveRecord::Migration[6.0]
  def change
    add_index :stocks, [:today_price, :yesterday_price]
  end
end
