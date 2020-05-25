class ChangeStocksCodeAndNameNotNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :stocks, :code, false
    change_column_null :stocks, :name, false
  end
end
