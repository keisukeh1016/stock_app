class ChangeStocksNameAndPriceToNotNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :stocks, :name, false
    change_column_null :stocks, :today_price, false
    change_column_null :stocks, :yesterday_price, false
  end
end
