class AddIndexToStocksCode < ActiveRecord::Migration[6.0]
  def change
    add_index :stocks, :code, unique: true
  end
end
