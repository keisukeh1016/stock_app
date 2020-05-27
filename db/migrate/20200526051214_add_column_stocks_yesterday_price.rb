class AddColumnStocksYesterdayPrice < ActiveRecord::Migration[6.0]
  def change
    add_column :stocks, :yesterday_price, :float
  end
end
