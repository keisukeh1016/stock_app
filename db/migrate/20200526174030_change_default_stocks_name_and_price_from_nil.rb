class ChangeDefaultStocksNameAndPriceFromNil < ActiveRecord::Migration[6.0]
  def change
    change_column_default :stocks, :name, from: nil, to: "unknown"
    change_column_default :stocks, :today_price, from: nil, to: 1.0
    change_column_default :stocks, :yesterday_price, from: nil, to: 1.0
  end
end
