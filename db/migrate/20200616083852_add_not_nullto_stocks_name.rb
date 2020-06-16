class AddNotNulltoStocksName < ActiveRecord::Migration[6.0]
  def change
    change_column_null :stocks, :name, false
    change_column_default :stocks, :name, from: nil, to: 'unknown'

    change_column_null :stocks, :today_price, false
    change_column_default :stocks, :today_price, from: nil, to: 1

    change_column_null :stocks, :yesterday_price, false
    change_column_default :stocks, :yesterday_price, from: nil, to: 1
  end
end
