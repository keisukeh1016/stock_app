class CreateStockIndexes < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_indexes do |t|
      t.string :name, null: false
      t.float :today_price, null: false, default: 1.0
      t.float :yesterday_price, null: false, default: 1.0
      t.float :dod_change, null: false, default: 0.0
      t.timestamps
    end
  end
end
