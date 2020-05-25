class RemoveStocksNameNotNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :stocks, :name, true
  end
end
