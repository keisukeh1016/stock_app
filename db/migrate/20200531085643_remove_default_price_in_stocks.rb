class RemoveDefaultPriceInStocks < ActiveRecord::Migration[6.0]
  def change
    change_column_null :stocks, :name, true
    change_column_null :stocks, :today_price, true
    change_column_null :stocks, :yesterday_price, true

    change_column_default :stocks, :name, from: 'unknown', to: nil
    change_column_default :stocks, :today_price, from: 1.0, to: nil
    change_column_default :stocks, :yesterday_price, from: 1.0, to: nil
  end
end
