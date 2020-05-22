class ChangeStockCodeIntegerToString < ActiveRecord::Migration[6.0]
  def change
    change_column :stocks, :code, :string
  end
end
