class DropTableStockIndexes < ActiveRecord::Migration[6.0]
  def up
    drop_table :stock_indexes
  end

  def down 
    create_table :stock_indexes
  end
end
