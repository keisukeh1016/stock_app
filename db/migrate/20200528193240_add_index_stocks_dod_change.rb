class AddIndexStocksDodChange < ActiveRecord::Migration[6.0]
  def change
    add_index :stocks, :dod_change
  end
end
